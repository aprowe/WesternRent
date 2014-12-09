class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # filter_parameter_logging :password

  # def admin?
  #   return true
  # end

  def gopro
    session[:user] = 'Go Pro'
    redirect_to ''
  end

  def index
    @user = user

    if not @user
      return redirect_to action: 'login'
    end

    @renters = Renter.all.where.not({id: user.id})

  end

  def user
    return Renter.find_by_name session[:user]
  end

  def self.user
    return Renter.find_by_name session[:user]
  end


  def post
    if not params[:message]
      return;
    end

    comment = Comments.create
    comment.renter_id = self.user.id
    comment.message = params[:message]
    comment.save

    render partial: 'comment', locals: {comment: comment}
    return
  end

  def updatePhone 
    renter = Renter.find(params[:id])
    renter.phone = params[:phone]
    renter.save
    render text: 'ok'
  end

  def getComments
    starting = params[:last].to_i
    string = ''

    comments = Comments.
      where('id > ?', starting).
      reverse_order

    comments.each do |comment|
      string += render_to_string partial: 'comment', locals: {comment: comment}
    end

    @return = {comments: string, last: Comments.last.id}

    render json: @return
  end

  def changePassword
    if params[:password]
      user = self.user
      user.new_password = params[:password]
      user.save
      render text: ""
      return
    end

    render text: 'No password supplied'
  end

  def userPaid
    if params[:id]
      renter = Renter.find( params[:id] )
      renter.paid = !renter.paid
      renter.save
      render text: 'success'
      return
    end

    render text: 'fail'
  end

  def postUtilities

    logger.debug params
    if params[:amount]
      util = Utilities.create
      util.amount = params[:amount].to_f
      util.save
      render text: 'success'
      return
    end

    render text: 'fail'
  end

  def sendTexts
    require "uri"
    require "net/http"


    message = ''
    Renter.
      where( {paid: false} ).where.not( phone: false ).each do |renter|

        message = "Dear #{renter.name}, this months rent is $#{renter.rent}, including utilities. Make a check out to #{House.first.rent}, or paypal to aprowe@ucsc.edu. Thanks!"

        params = {message: message, number: renter.phone}
        x = Net::HTTP.post_form(URI.parse('http://textbelt.com/text'), params)

        logger.debug x
        logger.debug "Message sent to #{renter.name}"

        sleep 61
    end

    render text: 'Done'

  end

  def messageUser
    renter = Renter.find params[:renter_id]

    message = "Dear #{renter.name}, this months rent is $#{renter.rent}, including utilities. Make a check out to #{House.first.rent}, or paypal to aprowe@ucsc.edu. Thanks!"

    params = {message: message, number: renter.phone}
    x = Net::HTTP.post_form(URI.parse('http://textbelt.com/text'), params)

    render text: "Message sent to #{renter.name}"
  end


  def login
    @error = ''
    @username = ''

    if cookies.signed[:user_id]
      user = Renter.find( cookies.signed[:user_id] )
      cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
      session[:user] = user
      redirect_to ''
      return
    end

    user = Renter.authenticate(params[:username], params[:password])

    if user
      session[:user] = user
      cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
      redirect_to ''
      return
    end

    # if params[:username]
    #   user = Renter.find_by_name( params[:username] )

    #   unless user
    #     user = Renter.find_by_username ( params[:username] )
    #   end

    #   if user 

    #     if user.password.to_s == params[:password].to_s || user.password.to_s == ''
    #         session[:user] = user
    #         cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
    #         redirect_to ''
    #         return
    #     end

    #   end

    #   @username = params[:username]
    
    if params[:username] or params[:password]
      @error = 'incorrect name or password'
    end



  end


  def upload

    uploaded_io = params[:picture]
    File.open(Rails.root.join('public', 'uploads', "#{user.id}.png"), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    redirect_to ''
  end

  def logout
    cookies.delete :user_id
    reset_session
    redirect_to action: 'login'
  end

  def createExpense
    if params[:description] and params[:price]
      expense = Expense.create
      expense.renter = user
      expense.amount = params[:price]
      expense.description = params[:description]
      expense.save
      render expense
    else
      render text: 'failure'
    end

  end

  def deleteExpense
    expense = Expense.find(params[:id])
    expense.delete
    render text: 'success'
  end

  def resetRent
    Renter.update_all(paid: false)
    render text: 'success'
  end

  def calcRent
    rent = House.first.calc_rents
    render text: rent
  end


end

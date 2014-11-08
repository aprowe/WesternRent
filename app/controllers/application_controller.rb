class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # def admin?
  #   return true
  # end

  def index

    @user = self.user

    if not @user
      return redirect_to action: 'login'
    end

    @renters = Renter.all.where.not({name: session[:user] })

    logger.debug House.first.rent
    logger.debug @user.name
    @admin = (@user.name.to_s == House.first.rent.to_s)
    @utilities = (@user.name.to_s == House.first.utilities.to_s)

  end

  def user
    return Renter.find_by_name( session[:user] )
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

  def adminLogin
    session[:user] = 'Alexander Rowe'
    redirect_to ''
  end

  def updatePhone 
    renter = Renter.find(params[:id])
    renter.phone = params[:phone]
    renter.save
    render text: 'ok'
  end

  def changePassword
    if params[:password]
      user = self.user
      user.password = params[:password]
      user.save
      render text: "password changed to #{user.password}"
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

        message = "Dear #{renter.name}, this months rent is $#{renter.rent}. Make a check out to #{House.first.rent}, or paypal to aprowe@ucsc.edu. Thanks!"

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

    message = "Dear #{renter.name}, this months rent is $#{renter.rent}. Make a check out to #{House.first.rent}, or paypal to aprowe@ucsc.edu. Thanks!"

    params = {message: message, number: renter.phone}
    x = Net::HTTP.post_form(URI.parse('http://textbelt.com/text'), params)

    render text: "Message sent to #{renter.name}"
  end


  def login
    @error = ''
    @username = ''

    if params[:username]
      user = Renter.find_by_name( params[:username] )

      if user

        if user.password.to_s == params[:password].to_s || user.password.to_s == ''
            session[:user] = user
            redirect_to ''
            return
        end

      end

      @username = params[:username]
    
    end



    @error = 'incorrect name or password'
  end


  def upload
    user = Renter.first

    uploaded_io = params[:picture]
    File.open(Rails.root.join('public', 'uploads', "#{user.id}.png"), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    redirect_to ''
  end

  def logout
    reset_session
    redirect_to action: 'login'
  end

  def adminUser
    if session[:user] == House.first.rent
        return true
    end

    return false
  end

  def utilityUser
    if session[:user] == House.first.utilities
        return true
    end

    return false
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

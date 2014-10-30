class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @renters = Renter.all
    @adminUser = adminUser

  end

  def adminLogin
    session[:user] = 'Alexander Rowe'
    redirect_to ''
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


  def login
    user = Renter.find_by_name(params[:username])

    if(user)
        session[:user] = user
        render text: params[:username]
    else
        render text: ''
    end
    
    return
  end

  def logout

    reset_session
    redirect_to ''
  end

  def adminUser
    if session[:user] == "Alexander Rowe"
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

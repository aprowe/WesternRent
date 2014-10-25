class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @renters = Renter.all
    @adminUser = adminUser

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

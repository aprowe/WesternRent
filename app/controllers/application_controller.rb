class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  	@renters = Renter.all
  	@post = House.first.calc_rents
 	House.first.reset_rent
  end

end

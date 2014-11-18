require 'bcrypt'

class AddHashedPasswordToRenters < ActiveRecord::Migration
  def change

  	Renter.all.each do |renter|
  		old_password = renter.password
  		renter.password = BCrypt::Password.create(old_password)
  		renter.save
  	end

  end
end

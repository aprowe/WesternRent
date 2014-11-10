class AddUsernameToRenters < ActiveRecord::Migration
  def change
    add_column :renters, :username, :string

    Renter.all.each do |renter|
    	renter.username = renter.name.gsub(/(^.).*\ /,'\1').downcase
    	renter.save
    end

  end
end

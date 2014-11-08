class AddPasswordToRenters < ActiveRecord::Migration
  def change
  	add_column :renters, :password, :string
  end
end

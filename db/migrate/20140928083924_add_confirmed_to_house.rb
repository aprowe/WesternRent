class AddConfirmedToHouse < ActiveRecord::Migration
  def change
  	add_column :houses, :confirmed, :boolean
  end
end

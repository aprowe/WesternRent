class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :description
      t.integer :rent
      t.decimal :area 
      t.boolean :rentable


      t.timestamps
    end
  end
end
class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :rent_id
      t.string :utilities_id

      t.decimal :total_rent
      t.decimal :total_area


      t.timestamps
    end
  end
end

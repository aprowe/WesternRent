class CreateRenters < ActiveRecord::Migration
  def change
    create_table :renters do |t|
      t.string :name
      t.string :phone
      t.string :picture
      t.boolean :paid
      t.belongs_to :room


      t.timestamps
    end
  end
end

class CreateRoomFactors < ActiveRecord::Migration
  def change
    create_table :room_factors do |t|
      t.belongs_to :room
      t.belongs_to :factor

      t.timestamps
    end
  end
end

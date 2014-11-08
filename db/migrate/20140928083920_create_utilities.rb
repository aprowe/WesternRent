class CreateUtilities < ActiveRecord::Migration
  def change
    create_table :utilities do |t|
      t.decimal :amount
      t.timestamps
    end
  end
end

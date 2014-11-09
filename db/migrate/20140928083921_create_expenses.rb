class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :renter

      t.string :description

      t.decimal :amount

      t.timestamps
    end
  end
end

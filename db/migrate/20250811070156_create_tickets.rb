class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :ticket_number
      t.string :status
      t.datetime :purchased_at
      t.integer :quantity

      t.timestamps
    end
  end
end

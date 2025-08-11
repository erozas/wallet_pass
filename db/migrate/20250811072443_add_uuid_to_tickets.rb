class AddUuidToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :uuid, :string
    add_index :tickets, :uuid, unique: true
  end
end

class ChangeTicketStatusToInteger < ActiveRecord::Migration[8.0]
  def up
    change_column :tickets, :status, :integer, default: 0
  end
  
  def down
    change_column :tickets, :status, :string
  end
end

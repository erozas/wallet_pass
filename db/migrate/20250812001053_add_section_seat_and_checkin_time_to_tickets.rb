class AddSectionSeatAndCheckinTimeToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :section, :string
    add_column :tickets, :seat, :string
    add_column :tickets, :checked_in_at, :datetime
  end
end

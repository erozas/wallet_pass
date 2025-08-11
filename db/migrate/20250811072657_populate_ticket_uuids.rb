class PopulateTicketUuids < ActiveRecord::Migration[8.0]
  def up
    Ticket.where(uuid: nil).find_each do |ticket|
      ticket.update!(uuid: SecureRandom.uuid)
    end
  end

  def down
    # No rollback needed
  end
end

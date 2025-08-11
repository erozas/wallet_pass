# == Schema Information
#
# Table name: tickets
#
#  id            :integer          not null, primary key
#  purchased_at  :datetime
#  quantity      :integer
#  status        :integer          default("pending")
#  ticket_number :string
#  uuid          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  event_id      :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_tickets_on_event_id  (event_id)
#  index_tickets_on_user_id   (user_id)
#  index_tickets_on_uuid      (uuid) UNIQUE
#
# Foreign Keys
#
#  event_id  (event_id => events.id)
#  user_id   (user_id => users.id)
#
require "test_helper"

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

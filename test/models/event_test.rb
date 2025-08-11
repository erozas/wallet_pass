# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  category           :string           default("active")
#  description        :text
#  doors_open_at      :datetime
#  event_date         :datetime
#  max_capacity       :integer
#  slug               :string
#  status             :string
#  ticket_price_cents :integer
#  tickets_sold_count :integer          default(0)
#  title              :string           not null
#  venue_address      :string
#  venue_lat          :decimal(10, 6)
#  venue_lng          :decimal(10, 6)
#  venue_name         :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  organizer_id       :integer          not null
#
# Indexes
#
#  index_events_on_event_date               (event_date)
#  index_events_on_organizer_id             (organizer_id)
#  index_events_on_slug                     (slug) UNIQUE
#  index_events_on_status                   (status)
#  index_events_on_venue_lat_and_venue_lng  (venue_lat,venue_lng)
#
# Foreign Keys
#
#  organizer_id  (organizer_id => organizers.id)
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

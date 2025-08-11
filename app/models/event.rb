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
class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :organizer
  has_one_attached :cover
  has_many :tickets, dependent: :destroy
  
  validates :title, presence: true
  validates :event_date, presence: true
  validates :organizer_id, presence: true
  
  scope :published, -> { where(status: 'published') }
  scope :upcoming, -> { where('event_date > ?', Time.current) }
  
  def formatted_price
    return "Free" if ticket_price_cents.nil? || ticket_price_cents.zero?
    "$#{'%.2f' % (ticket_price_cents / 100.0)}"
  end
  
  def sold_out?
    max_capacity.present? && tickets_sold_count >= max_capacity
  end
  
  def available_tickets
    return nil unless max_capacity.present?
    max_capacity - tickets_sold_count
  end
end

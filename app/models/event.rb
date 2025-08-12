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
#  seats_per_section  :integer          default(50)
#  sections           :text
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
  
  scope :upcoming, -> { where('event_date > ?', Time.current).order(:event_date) }
  
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
    return false unless max_capacity.present?
    
    # Check both max_capacity and actual seating availability
    capacity_sold_out = actual_tickets_sold >= max_capacity
    seating_sold_out = !has_available_seats?(1)
    
    capacity_sold_out || seating_sold_out
  end
  
  def available_tickets
    return nil unless max_capacity.present?
    
    # Calculate based on both capacity and available seats
    capacity_remaining = max_capacity - actual_tickets_sold
    total_seats = section_list.count * seats_per_section
    seats_remaining = total_seats - actual_tickets_sold
    
    [capacity_remaining, seats_remaining].min
  end
  
  def actual_tickets_sold
    tickets.confirmed.sum(:quantity)
  end
  
  def refresh_sold_count!
    update!(tickets_sold_count: actual_tickets_sold)
  end
  
  def section_list
    return ['A', 'B', 'C'] if sections.blank?
    YAML.safe_load(sections) rescue ['A', 'B', 'C']
  end
  
  def assign_seats_for_quantity(quantity)
    assigned_seats = []
    
    section_list.each do |section|
      break if assigned_seats.count >= quantity
      
      # Get all taken seats in this section
      taken_seats = tickets.confirmed
                          .where(section: section)
                          .pluck(:seat)
                          .map(&:to_i)
                          .sort
      
      # Find available seats in this section
      (1..seats_per_section).each do |seat_num|
        break if assigned_seats.count >= quantity
        
        unless taken_seats.include?(seat_num)
          assigned_seats << { section: section, seat: seat_num.to_s }
        end
      end
    end
    
    assigned_seats.take(quantity)
  end
  
  def has_available_seats?(quantity)
    assign_seats_for_quantity(quantity).count == quantity
  end
end

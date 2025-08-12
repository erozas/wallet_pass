# == Schema Information
#
# Table name: tickets
#
#  id            :integer          not null, primary key
#  checked_in_at :datetime
#  purchased_at  :datetime
#  quantity      :integer
#  seat          :string
#  section       :string
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
class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :ticket_number, presence: true, uniqueness: true
  validates :uuid, presence: true, uniqueness: true
  validates :status, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :section, presence: true
  validates :seat, presence: true
  validates :seat, uniqueness: { scope: [ :event_id, :section ], message: "has already been taken in this section" }

  enum :status, { pending: 0, confirmed: 1, used: 2, cancelled: 3 }

  delegate :title, :venue_name, :venue_lat, :venue_lng, :doors_open_at, :ticket_price_cents, to: :event, prefix: true

  before_validation :generate_ticket_number, on: :create
  before_validation :generate_uuid, on: :create

  def to_param
    uuid
  end

  scope :for_upcoming_events, -> { joins(:event).where("events.event_date > ?", Time.current) }
  scope :confirmed_tickets, -> { where(status: :confirmed) }

  def total_price
    return 0 if event.ticket_price_cents.nil?
    (event.ticket_price_cents * quantity) / 100.0
  end

  def formatted_total_price
    return "Free" if total_price == 0
    "$#{'%.2f' % total_price}"
  end

  def checked_in?
    checked_in_at.present?
  end

  def check_in!
    update!(checked_in_at: Time.current, status: :used)
  end

  def seat_location
    return nil if section.blank? || seat.blank?
    "Section #{section}, Seat #{seat}"
  end

  def passkit_url_ios
    Passkit::UrlGenerator.new(Passkit::EventTicket, self).ios
  end

  def android_wallet_url
    Passkit::UrlGenerator.new(Passkit::EventTicket, self).android
  end

  def truncated_venue_name
    event.venue_name.truncate(32)
  end

  def barcode_message
    {
      ticket_number: ticket_number,
      event_title: event.title,
      purchaser_id: user.id,
    }
  end

  private

  def generate_ticket_number
    self.ticket_number = "TKT-#{SecureRandom.hex(4).upcase}-#{Time.current.strftime('%y%m%d')}"
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end

module Passkit
  class EventTicket < BasePass
    include Rails.application.routes.url_helpers

    def initialize(generator)
      super(generator)
      @event = generator.event
    end

    def pass_type
      :eventTicket
    end

    def description
      @event.description || "Event Ticket"
    end

    def background_color
      hex_to_rgb("43A4F9")
    end

    def foreground_color
      hex_to_rgb("FFFFFF")
    end

    def locations
      [
        {"latitude" => @generator.event_venue_lat.to_f, "longitude" => @generator.event_venue_lng.to_f}
      ]
    end

    def header_fields
      [
        {
          key: "date",
          label: "Date",
          value: @event.event_date.strftime("%b %d")
        },
        {
          key: "time",
          label: "Time",
          value: @event.event_date.strftime("%I:%M")
        }
      ]
    end

    def logo_text
      ""
    end

    def primary_fields
      []
    end

    def secondary_fields
      [
        {
          key: "event",
          label: "Event",
          value: @event.title
        }
      ]
    end

    def auxiliary_fields
      [
        {
          key: "venue",
          label: "Venue",
          value: @generator.truncated_venue_name
        },
        {
          key: "price",
          label: "Price",
          value: ActionController::Base.helpers.humanized_money_with_symbol(Money.new(@event.ticket_price_cents || 0, 'USD'))
        },
        {
          key: "section",
          label: "Section",
          value: @generator.section  
        },
        {
          key: "seat",
          label: "Seat",
          value: @generator.seat
        }
      ]
    end

    def back_fields
      [
        {
          key: "event",
          label: "Event",
          value: @event.title
        },
        {
          key: "venue",
          label: "Venue",
          value: @generator.truncated_venue_name
        },
        {
          key: "price",
          label: "Price",
          value: ActionController::Base.helpers.humanized_money_with_symbol(Money.new(@event.ticket_price_cents || 0, 'USD'))
        }
      ]
    end

    def barcodes
      [
        { messageEncoding: "iso-8859-1",
          format: "PKBarcodeFormatQR",
          message: @generator.barcode_message.to_json}
      ]
    end

    def file_name
      @file_name ||= SecureRandom.uuid
    end

  private

    def folder_name
      "event_ticket"
    end

    def hex_to_rgb(hex)
      return "rgb(0, 0, 0)" if hex.nil? || hex.empty?
      
      hex = hex.gsub('#', '').upcase
      return "rgb(0, 0, 0)" unless hex.match?(/\A[0-9A-F]{6}\z/)
      
      r = hex[0..1].to_i(16)
      g = hex[2..3].to_i(16)
      b = hex[4..5].to_i(16)
      
      "rgb(#{r}, #{g}, #{b})"
    end
  end
end

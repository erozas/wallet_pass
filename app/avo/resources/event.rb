class Avo::Resources::Event < Avo::BaseResource
  self.includes = [:organizer]
  self.search = {
    query: -> { query.ransack(title_cont: q, venue_name_cont: q, venue_address_cont: q, m: "or").result(distinct: false) }
  }
  
  def fields
    field :id, as: :id
    field :title, as: :text, required: true
    field :slug, as: :text, readonly: true, hide_on: [:new, :edit]
    field :organizer, as: :belongs_to, required: true
    field :description, as: :textarea
    field :cover, as: :file, is_image: true, accept: "image/*"
    
    # Event details panel
    panel "Event Details", collapsible: true do
      field :event_date, as: :date_time, required: true
      field :doors_open_at, as: :date_time
      field :category, as: :select, options: [
        ["Conference", "conference"],
        ["Workshop", "workshop"],
        ["Concert", "concert"],
        ["Festival", "festival"],
        ["Exhibition", "exhibition"],
        ["Other", "other"]
      ]
      field :status, as: :select, options: [
        ["Draft", "draft"],
        ["Published", "published"],
        ["Cancelled", "cancelled"],
        ["Sold Out", "sold_out"]
      ]
    end
    
    # Venue information panel  
    panel "Venue Information", collapsible: true do
      field :venue_name, as: :text
      field :venue_address, as: :textarea
      field :venue_lat, as: :number, step: "any", placeholder: "e.g., 37.7749"
      field :venue_lng, as: :number, step: "any", placeholder: "e.g., -122.4194"
    end
    
    # Ticketing panel
    panel "Ticketing", collapsible: true do
      field :ticket_price_cents, as: :number, help: "Price in cents (e.g., 2500 for $25.00)"
      field :max_capacity, as: :number
      field :tickets_sold_count, as: :number, readonly: true, hide_on: [:new, :edit]
    end
    
    field :created_at, as: :date_time, hide_on: [:new, :edit]
    field :updated_at, as: :date_time, hide_on: [:new, :edit]
  end
end

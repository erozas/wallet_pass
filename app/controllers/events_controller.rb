class EventsController < ApplicationController
  allow_unauthenticated_access
  
  before_action :set_event, only: [:show]
  before_action :add_breadcrumbs

  def index
    @events = Event.includes(:organizer, cover_attachment: :blob)
    
    # Apply search filter if provided
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @events = @events.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ? OR LOWER(category) LIKE ? OR LOWER(venue_name) LIKE ?", 
                             search_term, search_term, search_term, search_term)
    end
    
    # Apply date filter if provided
    if params[:date].present?
      date = Date.parse(params[:date])
      @events = @events.where(event_date: date.beginning_of_day..date.end_of_day)
    else
      # Only show upcoming events if no specific date is searched
      @events = @events.where('event_date > ?', Time.current)
    end
    
    @events = @events.order(:event_date)
  rescue Date::Error
    # Invalid date format, ignore date filter
    @events = @events.where('event_date > ?', Time.current).order(:event_date)
  end

  def show
    add_breadcrumb @event.title, event_path(@event)
  end

  private

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def add_breadcrumbs
    add_breadcrumb "Home", root_path
    add_breadcrumb "Events", events_path
  end
end
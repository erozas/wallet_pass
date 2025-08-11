class EventsController < ApplicationController
  allow_unauthenticated_access
  
  before_action :set_event, only: [:show]
  before_action :add_breadcrumbs

  def index
    @events = Event.published.upcoming.includes(:organizer, cover_attachment: :blob).order(:event_date)
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
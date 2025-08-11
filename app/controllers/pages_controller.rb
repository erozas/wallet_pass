class PagesController < ApplicationController
  allow_unauthenticated_access only: :home
  
  def home
    @featured_events = Event.upcoming.limit(6).includes(:organizer, cover_attachment: :blob)
  end
end
class TicketsController < ApplicationController
  before_action :set_event, only: [:create]
  before_action :set_ticket, only: [:show, :download_pass, :check_in]

  def index
    @tickets = current_user.tickets.confirmed_tickets.for_upcoming_events.includes(:event).order(created_at: :desc)
  end

  def show
  end

  def create
    # Check if requested seats are available
    unless @event.has_available_seats?(ticket_params[:quantity].to_i)
      flash[:alert] = "Sorry, not enough seats available. Only #{@event.available_tickets} seats remaining."
      redirect_to event_path(@event)
      return
    end

    # Assign seats automatically
    assigned_seats = @event.assign_seats_for_quantity(ticket_params[:quantity].to_i)
    
    if assigned_seats.empty?
      flash[:alert] = "Unable to assign seats. Please try again."
      redirect_to event_path(@event)
      return
    end

    # Create tickets with assigned seats
    tickets_created = []
    
    ActiveRecord::Base.transaction do
      assigned_seats.each do |seat_assignment|
        ticket = current_user.tickets.create!(
          event: @event,
          status: :confirmed,
          purchased_at: Time.current,
          quantity: 1,
          section: seat_assignment[:section],
          seat: seat_assignment[:seat]
        )
        tickets_created << ticket
      end
      
      # Update event ticket count
      @event.refresh_sold_count!
    end

    ticket_word = tickets_created.count == 1 ? 'ticket' : 'tickets'
    seat_info = tickets_created.map(&:seat_location).join(', ')
    flash[:notice] = "Successfully purchased #{tickets_created.count} #{ticket_word} for #{@event.title}! Assigned seats: #{seat_info}"
    redirect_to ticket_path(tickets_created.first)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Ticket creation failed: #{e.message}"
    flash[:alert] = "Unable to purchase tickets: #{e.message}"
    redirect_to event_path(@event)
  end

  def download_pass
    begin
      pass_data = generate_wallet_pass(@ticket)
      send_data pass_data, 
                filename: "#{@ticket.event.title.parameterize}-ticket.pkpass",
                type: 'application/vnd.apple.pkpass',
                disposition: 'attachment'
    rescue => e
      Rails.logger.error "Wallet pass generation failed: #{e.message}"
      redirect_to ticket_path(@ticket), alert: "Unable to generate wallet pass. Please try again."
    end
  end

  def check_in
    if @ticket.check_in!
      flash[:notice] = "Ticket checked in successfully!"
    else
      flash[:alert] = "Unable to check in ticket."
    end
    redirect_to ticket_path(@ticket)
  end

  private

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end

  def set_ticket
    @ticket = current_user.tickets.find_by!(uuid: params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:quantity)
  end
end
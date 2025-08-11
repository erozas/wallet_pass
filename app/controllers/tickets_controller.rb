class TicketsController < ApplicationController
  before_action :set_event, only: [:create]
  before_action :set_ticket, only: [:show, :download_pass]

  def index
    @tickets = current_user.tickets.confirmed_tickets.for_upcoming_events.includes(:event).order(created_at: :desc)
  end

  def show
  end

  def create
    @ticket = current_user.tickets.build(ticket_params.merge(
      event: @event,
      status: :confirmed,
      purchased_at: Time.current
    ))

    if @ticket.save
      # Update event ticket count
      @event.increment(:tickets_sold_count, @ticket.quantity)
      @event.save!
      
      ticket_word = @ticket.quantity == 1 ? 'ticket' : 'tickets'
      flash[:notice] = "Successfully purchased #{@ticket.quantity} #{ticket_word} for #{@event.title}!"
      redirect_to ticket_path(@ticket)
    else
      Rails.logger.error "Ticket save failed: #{@ticket.errors.full_messages.join(', ')}"
      flash[:alert] = "Unable to purchase tickets: #{@ticket.errors.full_messages.join(', ')}"
      redirect_to event_path(@event)
    end
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

  private

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end

  def set_ticket
    @ticket = current_user.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:quantity)
  end
end
Passkit.configure do |config|
  config.available_passes['Passkit::EventTicket'] = -> { Ticket.last }
end

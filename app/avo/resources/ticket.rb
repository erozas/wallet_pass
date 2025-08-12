class Avo::Resources::Ticket < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  self.find_record_method = -> {
    Ticket.find_by(uuid: id)
  }

  def fields
    field :id, as: :id
    field :user, as: :belongs_to
    field :event, as: :belongs_to
    field :ticket_number, as: :text
    field :status, as: :text
    field :purchased_at, as: :date_time
    field :quantity, as: :number
  end
end

class Avo::Resources::Organizer < Avo::BaseResource
  self.includes = [:events]
  self.search = {
    query: -> { query.ransack(name_cont: q, company_name_cont: q, email_cont: q, m: "or").result(distinct: false) }
  }
  
  def fields
    field :id, as: :id
    field :name, as: :text, required: true
    field :email, as: :text, required: true, format_using: -> { link_to value, "mailto:#{value}" if value.present? }
    field :company_name, as: :text, required: true
    field :phone, as: :text, format_using: -> { link_to value, "tel:#{value}" if value.present? }
    field :website, as: :text, format_using: -> { link_to value, value, target: :_blank if value.present? }
    field :description, as: :textarea
    field :events, as: :has_many
    field :created_at, as: :date_time, hide_on: [:new, :edit]
    field :updated_at, as: :date_time, hide_on: [:new, :edit]
  end
end

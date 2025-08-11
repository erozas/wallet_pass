# == Schema Information
#
# Table name: organizers
#
#  id           :integer          not null, primary key
#  company_name :string           not null
#  description  :text
#  email        :string           not null
#  name         :string           not null
#  phone        :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_organizers_on_email  (email) UNIQUE
#
class Organizer < ApplicationRecord
  has_many :events, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :company_name, presence: true
end

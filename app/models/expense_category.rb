# == Schema Information
#
# Table name: expense_categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#

class ExpenseCategory < ActiveRecord::Base
  
  # -- Associations
  has_many :expenses, dependent: :destroy

  # -- Scopes
  default_scope -> { order(:name) }
  scope :search, ->(term) {
    where('name ILIKE :term', term: "%#{term}%")
  }

  # -- Validations
  validates :name, presence: true
  validates :name, uniqueness: true, case_sensitive: false
  
end

# == Schema Information
#
# Table name: expenses
#
#  id                  :integer          not null, primary key
#  incurred_on         :date
#  expense_category_id :integer
#  amount_in_cents     :integer
#  description         :text
#

class Expense < ActiveRecord::Base
  
  # -- Associations
  belongs_to :expense_category

  # -- Scopes
  default_scope -> { order(:incurred_on, :amount_in_cents) }
  scope :search, ->(term) {
    where('name ilike :term', term: "#{term}%")
  }

  # -- Validations
  validates :incurred_on, presence: true
  validates :expense_category, presence: true
  validates :amount_in_cents, presence: true
  


  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['amount']
  end

  include IntegerInCents
  
end

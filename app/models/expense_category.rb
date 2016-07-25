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
  
end
class Customer < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:last_name, :first_name) }

  # -- Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

end

class Customer < ActiveRecord::Base

  # -- Associations
  has_many :vehicles

  # -- Scopes
  default_scope -> { order(:last_name, :first_name) }
  scope :search, ->(term) {
    where('first_name like :term or last_name like :term', term: "#{term}%")
  }

  # -- Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dni, uniqueness: true, allow_blank: true

  def to_s
    "#{last_name}, #{first_name}"
  end

end

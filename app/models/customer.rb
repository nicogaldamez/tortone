class Customer < ActiveRecord::Base

  include SoftDestroyable

  # -- Associations
  has_many :vehicles, dependent: :destroy
  has_many :sales, dependent: :destroy

  # -- Scopes
  default_scope -> { order(:last_name, :first_name) }
  scope :active, -> { where(deleted_at: nil) }
  scope :search, ->(term) {
    where('first_name ilike :term or last_name ilike :term', term: "%#{term}%")
  }

  # -- Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dni, uniqueness: true, allow_blank: true
  validates :phones, presence: true
  validates :email, presence: true

  def to_s
    "#{last_name}, #{first_name}"
  end

  def permanent_destroy?
    sales.empty?
  end

  def first_name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end

  def last_name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end
end

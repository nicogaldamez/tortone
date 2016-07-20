class Attachment < ActiveRecord::Base

  # -- Associations
  belongs_to :vehicle

  # -- Misc
  dragonfly_accessor :file

end

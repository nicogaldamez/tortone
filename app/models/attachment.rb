# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  file_uid   :string
#  file_name  :string
#  vehicle_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attachment < ActiveRecord::Base

  # -- Associations
  belongs_to :vehicle

  # -- Misc
  dragonfly_accessor :file

end

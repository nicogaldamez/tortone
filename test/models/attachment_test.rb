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

require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

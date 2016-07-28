# == Schema Information
#
# Table name: coincidences
#
#  id               :integer          not null, primary key
#  buyer_id         :integer
#  vehicle_model_id :integer
#  brand_id         :integer
#  is_ignored       :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class CoincidenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

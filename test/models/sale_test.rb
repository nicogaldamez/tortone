# == Schema Information
#
# Table name: sales
#
#  id               :integer          not null, primary key
#  sold_on          :date
#  customer_id      :integer
#  vehicle_id       :integer
#  advance_in_cents :integer          default(0)
#  status           :integer          default(0)
#  price_in_cents   :integer
#  notes            :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class SaleTest < ActiveSupport::TestCase

  def setup
    @sale = sales(:lightning_mcqueen_to_carlos)
  end

  test 'should not save sale without customer' do
    @sale.customer = nil
    @sale.valid?
    assert_includes @sale.errors[:customer], 'no puede estar en blanco'
  end

  test 'should not save sale without vehicle' do
    @sale.vehicle = nil
    @sale.valid?
    assert_includes @sale.errors[:vehicle], 'no puede estar en blanco'
  end

  test 'should not save sale without price' do
    @sale.price = nil
    @sale.valid?
    assert_includes @sale.errors[:price], 'no puede estar en blanco'
  end

end

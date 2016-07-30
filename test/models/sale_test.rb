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

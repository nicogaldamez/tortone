require 'test_helper'

class BuyerFilterTest < ActiveSupport::TestCase

  def setup
    @carlos = buyers(:carlos)
    @silvia = buyers(:silvia)
  end

  test "should filter by first_name/last_name" do
    buyers = BuyerFilter.new(name: 'non_existent_name').call
    assert_empty buyers
    
    buyers = BuyerFilter.new(name: @carlos.first_name).call
    assert_includes buyers, @carlos
    assert_not_includes buyers, @silvia
  end

  test "should filter by date_from" do
    buyers = BuyerFilter.new(from: @carlos.created_at).call
    assert_includes buyers, @carlos
    
    buyers = BuyerFilter.new(from: 30.days.from_now.to_date).call
    assert_empty buyers
  end

  test 'should filter by date_to' do
    buyers = BuyerFilter.new(to: @carlos.created_at).call
    assert_includes buyers, @carlos
    
    buyers = BuyerFilter.new(to: 5.days.ago.to_date).call
    assert_empty buyers
  end

end

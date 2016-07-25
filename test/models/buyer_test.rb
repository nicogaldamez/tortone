require 'test_helper'

class BuyerTest < ActiveSupport::TestCase

  def setup
    @buyer = buyers(:carlos)
  end

  test "should not save buyer without first name" do
    @buyer.first_name = ''
    @buyer.valid?
    assert_includes @buyer.errors[:first_name], 'no puede estar en blanco'
  end

  test "should not save buyer without phone" do
    @buyer.phones = ''
    @buyer.valid?
    assert_includes @buyer.errors[:phones], 'no puede estar en blanco'
  end

  test 'should titleize last name on save' do
    @buyer.last_name = 'fangio'
    @buyer.save
    assert_equal 'Fangio', @buyer.last_name
  end

  test 'should titleize first name on save' do
    @buyer.first_name = 'juan manuel'
    @buyer.save
    assert_equal 'Juan Manuel', @buyer.first_name
  end

end

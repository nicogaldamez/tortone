# == Schema Information
#
# Table name: customers
#
#  id          :integer          not null, primary key
#  first_name  :string           not null
#  last_name   :string           not null
#  dni         :string
#  phones      :string
#  address     :string
#  email       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  def setup
    @customer = customers(:carlos)
  end

  test "should not save customer without first name" do
    @customer.first_name = ''
    @customer.valid?
    assert_includes @customer.errors[:first_name], 'no puede estar en blanco'
  end

  test "should not save customer without last name" do
    @customer.last_name = ''
    @customer.valid?
    assert_includes @customer.errors[:last_name], 'no puede estar en blanco'
  end

  test "should not save customer without phones" do
    @customer.phones = ''
    @customer.valid?
    assert_includes @customer.errors[:phones], 'no puede estar en blanco'
  end

  test "should not save customer without email" do
    @customer.email = ''
    @customer.valid?
    assert_includes @customer.errors[:email], 'no puede estar en blanco'
  end

  test 'should titleize first name on save' do
    @customer.first_name = 'carlos'
    @customer.save
    assert_equal 'Carlos', @customer.first_name
  end

  test 'should titleize last name on save' do
    @customer.last_name = 'galdámez'
    @customer.save
    assert_equal 'Galdámez', @customer.last_name
  end
end


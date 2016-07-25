require 'test_helper'

class BrandTest < ActiveSupport::TestCase

  def setup
    @brand = brands(:ford)
  end

  test "should not save brand without name" do
    @brand.name = nil
    @brand.valid?
    assert_includes @brand.errors[:name], 'no puede estar en blanco'
  end

  test "should titleize name" do
    @brand.name = 'ford'
    @brand.save
    assert_equal 'Ford', @brand.name
  end

end

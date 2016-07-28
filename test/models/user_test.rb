# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  crypted_password :string
#  salt             :string
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should not save user without email" do
    user = User.new(email: nil)
    user.valid?
    assert_includes user.errors[:email], 'no puede estar en blanco'
  end

  test "should not save user without password" do
    user = User.new(email: 'admin@admin.com')
    user.password = nil
    user.valid?
    assert_includes user.errors[:password], 'no puede estar en blanco'
  end
  
end

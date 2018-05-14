require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'find one' do
    assert_equal 'Facebook User', users(:one).name
  end

  test 'find two' do
    assert_equal 'Twitter User', users(:two).name
  end

  test 'find all by name' do
    assert_equal 2, sale_records(:one, :two).length
  end

  test 'find all' do
    assert_equal 2, sale_records.length
  end

  test 'find by name that does not exist' do
    assert_raise(StandardError) { sale_records(:three) }
  end
  
  test 'missing provider field' do
    user = User.new
    user.uid = '2343324'
    user.name = 'Name test 1'
    assert_not user.save
  end
  
  test 'missing uid field' do
    user = User.new
    user.provider = 'facebook'
    user.name = 'Name test 1'
    assert_not user.save
  end
  
  test 'duplicated facebook provider and uid' do
    user = User.new
    user.provider = 'facebook'
    user.uid = '2344534556'
    user.name = 'Name test 1'
    assert_not user.save
  end
  
  test 'duplicated twitter provider and uid' do
    user = User.new
    user.provider = 'twitter'
    user.uid = '4545787645336'
    user.name = 'Name test 1'
    assert_not user.save
  end
  
  test 'user ok' do
    user = User.new
    user.provider = 'facebook'
    user.uid = '2343324'
    user.name = 'Name test 1'
    assert user.save
  end
end

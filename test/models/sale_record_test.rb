require 'test_helper'

class SaleRecordTest < ActiveSupport::TestCase

  test 'find one' do
    assert_equal 'Carrefour', sale_records(:one).merchant_name
  end

  test 'find two' do
    assert_equal 'Bahamas', sale_records(:two).merchant_name
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

  test 'missing purchase name field' do
    sale_record = SaleRecord.new
    sale_record.item_description = 'Candy bar'
    sale_record.item_price = 9.99
    sale_record.purchase_count = 1
    sale_record.merchant_address = 'Av. Joao Naves, 1331'
    sale_record.merchant_name = 'Carrefour'
    assert_not sale_record.save
  end

  test 'missing item description field' do
    sale_record = SaleRecord.new
    sale_record.purchaser_name = 'John Malkovich'
    sale_record.item_price = 9.99
    sale_record.purchase_count = 1
    sale_record.merchant_address = 'Av. Joao Naves, 1331'
    sale_record.merchant_name = 'Carrefour'
    assert_not sale_record.save
  end

  test 'missing item price field' do
    sale_record = SaleRecord.new
    sale_record.purchaser_name = 'John Malkovich'
    sale_record.item_description = 'Candy bar'
    sale_record.purchase_count = 1
    sale_record.merchant_address = 'Av. Joao Naves, 1331'
    sale_record.merchant_name = 'Carrefour'
    assert_not sale_record.save
  end

  test 'missing purchase count field' do
    sale_record = SaleRecord.new
    sale_record.purchaser_name = 'John Malkovich'
    sale_record.item_description = 'Candy bar'
    sale_record.item_price = 9.99
    sale_record.merchant_address = 'Av. Joao Naves, 1331'
    sale_record.merchant_name = 'Carrefour'
    assert_not sale_record.save
  end

  test 'missing merchant address field' do
    sale_record = SaleRecord.new
    sale_record.purchaser_name = 'John Malkovich'
    sale_record.item_description = 'Candy bar'
    sale_record.item_price = 9.99
    sale_record.purchase_count = 1
    sale_record.merchant_name = 'Carrefour'
    assert_not sale_record.save
  end

  test 'missing merchant name field' do
    sale_record = SaleRecord.new
    sale_record.purchaser_name = 'John Malkovich'
    sale_record.item_description = 'Candy bar'
    sale_record.item_price = 9.99
    sale_record.purchase_count = 1
    sale_record.merchant_address = 'Av. Joao Naves, 1331'
    assert_not sale_record.save
  end

  test 'sale record ok' do
    sale_record = SaleRecord.new
    sale_record.purchaser_name = 'John Malkovich'
    sale_record.item_description = 'Candy bar'
    sale_record.item_price = 9.99
    sale_record.purchase_count = 1
    sale_record.merchant_address = 'Av. Joao Naves, 1331'
    sale_record.merchant_name = 'Carrefour'
    assert sale_record.save
  end
end


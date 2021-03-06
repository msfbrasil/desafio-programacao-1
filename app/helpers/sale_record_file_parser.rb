class SaleRecordFileParser < TextFileParser

  @sale_records_list = Array.new

  def initialize( uploaded_file, original_file_name )

    Rails.logger.debug 'uploaded_file = ' + uploaded_file.to_s
    Rails.logger.debug 'original_file_name = ' + original_file_name.to_s

    super( uploaded_file, original_file_name, { :col_sep => "\t" }, 1, true, nil )

  end

  def self.sale_records_list
    @sale_records_list
  end

  def get_sale_records_list

    Rails.logger.info 'Starging sale records file parsing process...'

    parse_file

    return self.class.sale_records_list

  end

  def process_row_info( row, row_number )

    if ( row.length != 6 )
      raise Exceptions::WrongNumberOfColumnsError, 'Row [' + row_number.to_s + '] has wrong number of columns [' + row.length.to_s + '].'
    end

    Rails.logger.debug 'Row has ' + row.length.to_s + ' columns, which are:'

    Rails.logger.debug 'Purchaser name: ' + row[0] + ', Item description: ' 
      + row[1] + ', Item price: ' + row[2] + ', Purchase count: ' + row[3] 
      + ',Merchant address: ' + row[4] + ',Merchant name: ' + row[5]

    @sale_record = SaleRecord.new
    @sale_record.purchaser_name = row[0]
    @sale_record.item_description = row[1]
    begin
      @sale_record.item_price = BigDecimal.new( row[2] )
    rescue StandardError
      raise Exceptions::InvalidFieldError, 'Item price with invalid value [' + row[2] + '] at row [' + row_number.to_s + '].'
    end
    begin
      @sale_record.purchase_count = Integer( row[3] )
    rescue StandardError
      raise Exceptions::InvalidFieldError, 'Purchase count with invalid value [' + row[3] + '] at row [' + row_number.to_s + '].'
    end
    @sale_record.merchant_address = row[4]
    @sale_record.merchant_name = row[5]

    self.class.sale_records_list << @sale_record

    row_number += 1

  end

end


class SaleRecordFileParser
  
  def initialize( uploaded_file, original_file_name )
    
    @uploaded_file = uploaded_file
    @original_file_name = original_file_name
    
    #puts 'uploaded_file = ' + @uploaded_file.to_s
    #puts 'original_file_name = ' + @original_file_name.to_s
    
  end

  def parse_file

    #puts 'Starging sale records file parsing process...'
    
    @sale_records_list = Array.new
    @row_number = 1

    TextFileParser.new( @uploaded_file, @original_file_name, { :col_sep => "\t" }, 1, method(:row_parser), true, nil ).parse_file
    
    return @sale_records_list
    
  end
  
  def row_parser( row )
    
    if ( row.length != 6 )
      raise Exceptions::WrongNumberOfColumnsError, 'Row [' + @row_number.to_s + '] has wrong number of columns [' + row.length.to_s + '].'
    end
    
    #puts 'Row has ' + row.length.to_s + ' columns, which are:'
    
    #puts 'Purchaser name: ' + row[0]
    #puts 'Item description: ' + row[1]
    #puts 'Item price: ' + row[2]
    #puts 'Purchase count: ' + row[3]
    #puts 'Merchant address: ' + row[4]
    #puts 'Merchant name: ' + row[5]
    
    @sale_record = SaleRecord.new
    @sale_record.purchaser_name = row[0]
    @sale_record.item_description = row[1]
    begin
      @sale_record.item_price = BigDecimal.new( row[2] )
    rescue StandardError
      raise Exceptions::InvalidFieldError, 'Item price with invalid value [' + row[2] + '] at row [' + @row_number.to_s + '].'
    end
    begin
      @sale_record.purchase_count = Integer( row[3] )
    rescue StandardError
      raise Exceptions::InvalidFieldError, 'Purchase count with invalid value [' + row[3] + '] at row [' + @row_number.to_s + '].'
    end
    @sale_record.merchant_address = row[4]
    @sale_record.merchant_name = row[5]
    
    @sale_records_list << @sale_record
    
    @row_number += 1
    
  end
  
end


class SaleRecordFileParser
  
  def initialize( uploadedFile, originalFileName )
    
    @uploadedFile = uploadedFile
    @originalFileName = originalFileName
    
    puts 'uploadedFile = ' + @uploadedFile.to_s
    puts 'originalFileName = ' + @originalFileName.to_s
    
  end


  def parseFile

    puts 'Starging sale records file parsing process...'
    
    @saleRecordsList = Array.new
    @rowNumber = 1

    TextFileParser.new( @uploadedFile, @originalFileName, { :col_sep => "\t" }, 1, method(:rowParser), true, nil ).parseFile
    
    return @saleRecordsList
    
  end
  
  def rowParser( row )
    
    if ( row.length != 6 )
      raise Exceptions::WrongNumberOfColumnsError, 'Row [' + @rowNumber.to_s + '] has wrong number of columns [' + row.length.to_s + '].'
    end
    
    puts 'Row has ' + row.length.to_s + ' columns, which are:'
    
    puts 'Purchaser name: ' + row[0]
    puts 'Item description: ' + row[1]
    puts 'Item price: ' + row[2]
    puts 'Purchase count: ' + row[3]
    puts 'Merchant address: ' + row[4]
    puts 'Merchant name: ' + row[5]
    
    @saleRecord = SaleRecord.new
    @saleRecord.purchaser_name = row[0]
    @saleRecord.item_description = row[1]
    begin
      @saleRecord.item_price = BigDecimal.new( row[2] )
    rescue StandardError
      raise Exceptions::InvalidFieldError, 'Item price with invalid value [' + row[2] + '] at row [' + @rowNumber.to_s + '].'
    end
    begin
      @saleRecord.purchase_count = Integer( row[3] )
    rescue StandardError
      raise Exceptions::InvalidFieldError, 'Purchase count with invalid value [' + row[3] + '] at row [' + @rowNumber.to_s + '].'
    end
    @saleRecord.merchant_address = row[4]
    @saleRecord.merchant_name = row[5]
    
    @saleRecordsList << @saleRecord
    
    @rowNumber += 1
    
  end
  
end


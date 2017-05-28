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

    TextFileParser.new( @uploadedFile, @originalFileName, { :col_sep => "\t" }, 1, method(:rowParser), true, nil ).parseFile
    
    return @saleRecordsList
    
  end
  
  def rowParser( row )
    
    puts 'Row is of class type: ' + row.class.to_s
    puts 'Row has ' + row.length.to_s + ' itens, which are:'
    
    # TODO: Throw specific exception when the number of columns don't match.
    
    puts 'Purchaser name: ' + row[0]
    puts 'Item description: ' + row[1]
    puts 'Item price: ' + row[2]
    puts 'Purchase count: ' + row[3]
    puts 'Merchant address: ' + row[4]
    puts 'Merchant name: ' + row[5]
    
    @saleRecord = SaleRecord.new
    @saleRecord.purchaser_name = row[0]
    @saleRecord.item_description = row[1]
    @saleRecord.item_price = BigDecimal.new( row[2] )
    @saleRecord.purchase_count = row[3].to_i
    @saleRecord.merchant_address = row[4]
    @saleRecord.merchant_name = row[5]
    
    @saleRecordsList << @saleRecord
    
  end
  
end


class UploadController < ApplicationController
  
  require 'bigdecimal'
  
  def index
    render :file => 'app/views/upload/uploadfile.html.erb'
  end
  
  def uploadFile
    
    uploaded_io = params[:uploadedFile]
    puts 'Uploaded_io is a Class of type: ' + uploaded_io.class.to_s
    puts 'Uploaded_io[datafile] is a Class of type: ' + uploaded_io['datafile'].class.to_s
    puts 'Uploaded_io[datafile].tempfile is a Class of type: ' + uploaded_io['datafile'].tempfile.class.to_s
    puts 'Uploaded_io[datafile].original_filename = ' + uploaded_io['datafile'].original_filename

    @total_value = BigDecimal.new("0")
    
    begin
      text_file_parser = TextFileParser.new( uploaded_io['datafile'].tempfile, uploaded_io['datafile'].original_filename, { :col_sep => "\t" }, 1, method(:rowParser), true, nil ).parseFile
    
      render plain: "File has been uploaded successfully and total value is: " + @total_value.to_s
      
    rescue Exception => e
      
      render plain: 'Failure [' + e.message + '] detected while parsing file: ' + e.backtrace.inspect
      
    end
    
  end
  
  def rowParser( row )
    
    puts 'Row is of class type: ' + row.class.to_s
    puts 'Row has ' + row.length.to_s + ' itens, which are:'
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
    
    @saleRecord.save
    
    @total_value += ( BigDecimal.new( row[2] ) * row[3].to_i )
    
  end
  
end


class UploadController < ApplicationController
  require 'csv'
  require 'bigdecimal'
  
  def index
    render :file => 'app/views/upload/uploadfile.html.erb'
  end
  
  def uploadFile
    uploaded_io = params[:uploadedFile]
    new_file_name = Rails.root.join('public', 'uploads', uploaded_io['datafile'].original_filename)
    puts 'New file name: ' + new_file_name.to_s
    # First we make a copy of the file.
    File.open(new_file_name, 'wb') do |file|
      file.write(uploaded_io['datafile'].read)
    end
    # Now we process it.
    tabbed_rows = CSV.read(new_file_name, { :col_sep => "\t" })
    tabbed_rows.shift
    total_value = BigDecimal.new("0")
    tabbed_rows.each do |row|
      
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
      
      total_value += ( BigDecimal.new( row[2] ) * row[3].to_i )
      
    end
    # render :text => "File has been uploaded successfully and total value is: " + total_value.to_s
    render plain: "File has been uploaded successfully and total value is: " + total_value.to_s
  end
end

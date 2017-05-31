class UploadController < ApplicationController
  
  require 'bigdecimal'
  
  def index
    render :file => 'app/views/upload/uploadfile.html.erb'
  end
  
  def uploadFile
    
    uploaded_io = params[:uploadedFile]

    #puts 'Uploaded_io is a Class of type: ' + uploaded_io.class.to_s
    #puts 'Uploaded_io[datafile] is a Class of type: ' + uploaded_io['datafile'].class.to_s
    #puts 'Uploaded_io[datafile].tempfile is a Class of type: ' + uploaded_io['datafile'].tempfile.class.to_s
    #puts 'Uploaded_io[datafile].original_filename = ' + uploaded_io['datafile'].original_filename
    
    @total_value = BigDecimal.new("0")
    
    begin
      
      saleRecordsList = SaleRecordFileParser.new( uploaded_io['datafile'].tempfile, uploaded_io['datafile'].original_filename ).parseFile
      
      saleRecordsList.each { | saleRecord | 
        
         @total_value += ( saleRecord.item_price * saleRecord.purchase_count )
         
         saleRecord.save
      }
      
      render plain: "File has been uploaded successfully and total value is: " + @total_value.to_s
      
    rescue InvalidFileMimeTypeError => ifmte
      
      render plain: 'Failure detected while parsing file with message: ' + ifmte.message
      
    rescue WrongNumberOfColumnsError => wnoce
      
      render plain: 'Failure detected while parsing file with message: ' + wnoce.message
      
    rescue InvalidFieldError => ife
      
      render plain: 'Failure detected while parsing file with message: ' + ife.message
      
    rescue InvalidFileFormatError => iffe
      
      render plain: 'Failure detected while parsing file with message: ' + iffe.message
      
    end
    
  end
  
end


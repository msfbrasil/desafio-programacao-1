module Pages
  class SaleRecordsController < ApplicationController

    require 'bigdecimal'
    require 'exceptions'

    def index
    end

    def upload_file

      uploaded_io = params[:uploadedFile]

      if ( !uploaded_io )

        flash[:warning] = "A file must be provided!"

        redirect_to pages_salerecords_path

        return

      end

      Rails.logger.debug 'Uploaded_io[datafile].original_filename = ' + uploaded_io['datafile'].original_filename

      @total_value = BigDecimal.new("0")

      begin

        sale_records_list = SaleRecordFileParser.new( uploaded_io['datafile'].tempfile, uploaded_io['datafile'].original_filename ).get_sale_records_list

        sale_records_list.each { | sale_record | 

          @total_value += ( sale_record.item_price * sale_record.purchase_count )

          sale_record.save
        }

        flash[:success] = "File has been uploaded successfully and total value is: " + @total_value.to_s

        redirect_to pages_salerecords_path

      rescue StandardError => e

        Rails.logger.error "Failure detected while parsing file with message: " + e.message

        flash[:danger] = "Failure detected while parsing file with message: " + e.message

        redirect_to pages_salerecords_path

      end

    end

  end

end


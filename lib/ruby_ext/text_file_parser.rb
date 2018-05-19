# This class provides means to parse text files.
class TextFileParser

  require 'csv'
  require 'date'
  require 'filemagic'

  # Initializes the parser.
  # Params:
  # +parsing_file+:: the file to be parsed.
  # +original_file_name+:: when the provided file is an uploaded file, this parameter allows to provide the original file name in order to be used by the save copy option (may be nil).
  # +field_separator+:: the field separator to be used while parsing the file.
  # +header_lines_qtty+:: quantity of lines that represent the file header and must be skipped during the parsing.
  # +save_copy+:: indicates if a safe copy must be performed before the file is parsed.
  # +save_copy_base_path+:: provides where the copy must be placed. If none is provided, the default is "./tmp/uploads".
  #
  def initialize( parsing_file, original_file_name, field_separator, header_lines_qtty, save_copy, save_copy_base_path )

    @parsing_file = parsing_file
    @original_file_name = original_file_name
    @field_separator = field_separator
    @header_lines_qtty = header_lines_qtty
    @save_copy = save_copy
    if ( save_copy_base_path.to_s.empty? )
      @save_copy_base_path = Rails.root.join('tmp', 'uploads')
    else
      @save_copy_base_path = save_copy_base_path
    end

    #puts 'parsing_file = ' + @parsing_file.to_s
    #puts 'original_file_name = ' + @original_file_name.to_s
    #puts 'field_separator = ' + @field_separator.to_s
    #puts 'header_lines_qtty = ' + @header_lines_qtty.to_s
    #puts 'save_copy = ' + @save_copy.to_s
    #puts 'save_copy_base_path = ' + @save_copy_base_path.to_s

  end

  def parse_file

    #puts 'Starging file parsing process...'

    #puts 'Detecting mime type for file = ' + File.absolute_path( @parsing_file )
    #puts 'File mime type = ' + FileMagic.new(FileMagic::MAGIC_MIME).file( File.absolute_path( @parsing_file ), true )

    if ( !FileMagic.new(FileMagic::MAGIC_MIME).file( File.absolute_path( @parsing_file ), true ).eql? 'text/plain' )
      raise Exceptions::InvalidFileMimeTypeError, 'Provided file has invalid mime type [' + FileMagic.new(FileMagic::MAGIC_MIME).file( File.absolute_path( @parsing_file ), true ) + '].'
    end

    processing_file = @parsing_file

    if ( @save_copy )
      processing_file = save_copy_of_file
    end

    #puts 'Processing file = ' + processing_file.to_s

    begin

      tabbed_rows = nil
      if ( @field_separator.to_s.empty? )
        tabbed_rows = CSV.read(processing_file)
      else
        tabbed_rows = CSV.read(processing_file, @field_separator)
      end

      $index = 0

      while $index < @header_lines_qtty do
        tabbed_rows.shift
        $index += 1
      end

      $row_number = 1;

      tabbed_rows.each do |row|

        process_row_info( row, $row_number )
        $row_number += 1

      end

    rescue CSV::MalformedCSVError => e

      raise Exceptions::InvalidFileFormatError, 'Provided file thrown malformed CSV error with message: ' + e.message

    end

  end

  def process_row_info( row )

    raise NotImplementedError, "Subclasses must define `process_row_info` method."

  end

private

  def save_copy_of_file

    #puts 'Creating file copy...'

    current_date = DateTime.parse(Time.now.to_s)

    if ( @original_file_name.to_s.empty? )
      file_extension = File.extname( File.basename( @parsing_file ) )
      file_base_name = File.basename( File.basename( @parsing_file ), file_extension )
    else
      file_extension = File.extname( @original_file_name )
      file_base_name = File.basename( @original_file_name, file_extension )
    end

    #puts 'file_extension = ' + file_extension
    #puts 'file_base_name = ' + file_base_name
    #puts 'save_copy_base_path = ' + @save_copy_base_path.to_s
    #puts 'File data sufix = ' + current_date.strftime("%F-%T")

    new_file_name = @save_copy_base_path.to_s + "/" + file_base_name + "_" + current_date.strftime("%F-%T") + file_extension
    #puts 'New file name: ' + new_file_name.to_s
    File.open(new_file_name, 'wb') do |file|
      file.write(@parsing_file.read)
      return file
    end

  end

end


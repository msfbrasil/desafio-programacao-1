require 'test_helper'
require 'exceptions'

class SaleRecordFileParserTest < ActiveSupport::TestCase
  
  def test_file_wrong_type_1
    
    assert_raise( Exceptions::InvalidFileMimeTypeError ) {
      SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/standard.pdf' ), nil ).parseFile
    }
    
  end
  
  def test_file_wrong_type_2
    
    assert_raise( Exceptions::InvalidFileFormatError ) {
      SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/layout_memory.xml' ), nil ).parseFile
    }
    
  end
  
  def test_file_with_invalid_values
    
    assert_raise( Exceptions::InvalidFieldError ) {
      SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/example_input_invalid_values.tab' ), nil ).parseFile
    }
    
  end
  
  def test_file_with_wrong_number_of_columns
    
    assert_raise( Exceptions::WrongNumberOfColumnsError ) {
      SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/example_input_wrong_number_of_columns.tab' ), nil ).parseFile
    }
    
  end
  
  def test_ok
    
    saleRecordsList = SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/example_input.tab' ), nil ).parseFile
    
    assert_equal( 4, saleRecordsList.length )
    
  end
  
end

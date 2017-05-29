require 'test_helper'

class SaleRecordFileParserTest < ActiveSupport::TestCase
  
  def test_file_wrong_type
    
    assert_raise( Exception ) {
      SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/standard.pdf' ), nil ).parseFile
    }
    
  end
  
  def test_file_wrong_content
    
    assert_raise( Exception ) {
      SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/layout_memory.xml' ), nil ).parseFile
    }
    
  end
  
  def test_file_with_invalid_values
    
    assert_raise( Exception ) {
      SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/example_input_invalid_values.tab' ), nil ).parseFile
    }
    
  end
  
  def test_ok
    
    SaleRecordFileParser.new( File.open( File.dirname( __FILE__ ) + '/../resources/example_input.tab' ), nil ).parseFile
    
  end
  
end

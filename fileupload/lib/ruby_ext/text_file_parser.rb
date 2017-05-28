class TextFileParser
  
  require 'csv'
  require 'date'
  
  attr_accessor :uploadedFile, :originalFileName, :fieldSeparator, :headerLinesQtty, :rowCallbackMethod, :saveCopy, :saveCopyBasePath
  
  def initialize( uploadedFile, originalFileName, fieldSeparator, headerLinesQtty, rowCallbackMethod, saveCopy, saveCopyBasePath )
    @uploadedFile = uploadedFile
    @originalFileName = originalFileName
    @fieldSeparator = fieldSeparator
    @headerLinesQtty = headerLinesQtty
    @rowCallbackMethod = rowCallbackMethod
    @saveCopy = saveCopy
    if ( saveCopyBasePath.to_s.empty? )
      @saveCopyBasePath = Rails.root.join('public', 'uploads')
    else
      @saveCopyBasePath = saveCopyBasePath
    end
    
    puts 'uploadedFile = ' + @uploadedFile.to_s
    puts 'originalFileName = ' + @originalFileName.to_s
    puts 'fieldSeparator = ' + @fieldSeparator.to_s
    puts 'headerLinesQtty = ' + @headerLinesQtty.to_s
    puts 'rowCallbackMethod = ' + @rowCallbackMethod.to_s
    puts 'saveCopy = ' + @saveCopy.to_s
    puts 'saveCopyBasePath = ' + @saveCopyBasePath.to_s
    
  end
  
  def parseFile
    
    puts 'Starging file parsing process...'
    
    processing_file = @uploadedFile
    
    if ( saveCopy )
      processing_file = saveCopyOfFile
    end
    
    puts 'Processing file = ' + processing_file.to_s
    
    tabbed_rows = nil
    if ( @fieldSeparator.to_s.empty? )
      tabbed_rows = CSV.read(processing_file)
    else
      tabbed_rows = CSV.read(processing_file, @fieldSeparator)
    end
    
    $index = 0
    
    while $index < @headerLinesQtty do
      tabbed_rows.shift
      $index += 1
    end
    
    tabbed_rows.each do |row|
      
      @rowCallbackMethod.call( row )
      
    end
    
  end
  
  
  def saveCopyOfFile
    
    puts 'Creating file copy...'
    
    current_date = DateTime.parse(Time.now.to_s)
    
    if ( @originalFileName.to_s.empty? )
      file_extension = File.extname( File.basename( @uploadedFile ) )
      file_base_name = File.basename( File.basename( @uploadedFile ), file_extension )
    else
      file_extension = File.extname( @originalFileName )
      file_base_name = File.basename( @originalFileName, file_extension )
    end
    
    puts 'file_extension = ' + file_extension
    puts 'file_base_name = ' + file_base_name
    puts 'saveCopyBasePath = ' + @saveCopyBasePath.to_s
    puts 'File data sufix = ' + current_date.strftime("%F-%T")
    
    new_file_name = @saveCopyBasePath.to_s + "/" + file_base_name + "_" + current_date.strftime("%F-%T") + file_extension
    puts 'New file name: ' + new_file_name.to_s
    File.open(new_file_name, 'wb') do |file|
      file.write(@uploadedFile.read)
      return file
    end
    
  end
  
end

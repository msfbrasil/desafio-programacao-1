module Exceptions
  class InvalidFileFormatError < StandardError; end
  class InvalidFileMimeTypeError < StandardError; end
  class WrongNumberOfColumnsError < StandardError; end
  class InvalidFieldError < StandardError; end
end


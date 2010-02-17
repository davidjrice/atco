$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open3'
require 'tempfile'  


module Atco
  VERSION = '0.0.1'
  
  class << self
    
    @path = nil
    
    def parse(file)
      @path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'data', file))
      data = File.readlines(@path)
      puts(data.first.inspect)
    end
    
    def parse_header(string)
      {
        :file_type => string[0,8],
        :version => "#{string[8,2].to_i}.#{string[10,2].to_i}",
        :file_originator => string[12,32].strip!,
        :source_product => string[44,16].strip!,
        :production_datetime => string[60,14]
      } 
    end
    
  end
  
end
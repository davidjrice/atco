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
    
    def parse_bank_holiday(string)
      {
        :record_identity => string[0,2],
        :transaction_type => string[2,1],
        :date_of_bank_holiday => string[3,8]
      }
    end
    
    def parse_operator(string)
      {
        :record_identity => string[0,2],
        :transaction_type => string[2,1],
        :operator => string[3,4].strip,
        :operator_short_form => string[7,24].strip,
        :operator_legal_name => string[31,48].strip
      }
    end
    
    def parse_additional_location_info(string)
      {
        :record_identity => string[0,2],
        :transaction_type => string[2,1],
        :location => string[3,12].strip,
        :grid_reference_easting => string[15,8].strip,
        :grid_reference_northing => string[23,8].strip
      }
    end
    
  end
  
end
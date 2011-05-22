module Atco

  class Header

    attr_accessor :file_type, :version, :file_originator, :source_product, :production_datetime
    
    def initialize(data)
      @file_type = data[:file_type]
      @version = data[:version]
      @file_originator = data[:file_originator]
      @source_product = data[:source_product]
      @production_datetime = data[:production_datetime]
    end
    
  end
end
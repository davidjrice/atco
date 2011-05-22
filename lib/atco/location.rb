module Atco
  
  class Location

    attr_accessor :name, :identifier, :easting, :northing, :gazeteer_code, :short_code
    attr_writer :name, :identifier, :easting, :northing, :gazeteer_code, :short_code

    def initialize(location_header)
      @name = location_header[:full_location]
      @identifier = location_header[:record_identity]
      @gazeteer_code = location_header[:gazetteer_code]
    end

    def to_json(*a)
      { 
        :name => @name,
        :identifier => @identifier,
        :easting => @easting,
        :northing => @northing,
        :gazeteer_code => @gazeteer_code 
      }.to_json(*a)
    end

  end

end
module Atco
  
  class JourneyRoute

    attr_accessor :record_identity, :provider, :route_name, :route_text
    attr_writer :record_identity, :provider, :route_name, :route_text
    
    def initialize(data)
      @record_identity = data[:record_identity]
      @provider = data[:provider]
      @route_name = data[:route_name]
      @route_text = data[:route_text]
    end
    
  end

end
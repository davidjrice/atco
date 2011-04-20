module Atco

  class JourneyTimes

    attr_accessor :journey_identifiers, :record_identity, :start_time, :end_time, :days_of_the_week_text, :z_locations, :journey_route
    attr_writer :journey_identifiers, :record_identity, :start_time, :end_time, :days_of_the_week_text, :z_locations, :journey_route
    
    def initialize(data)
      @record_identity = data[:record_identity]
      @start_time = data[:start_time]
      @days_of_the_week_text = data[:days_of_the_week_text]
      @z_locations = data[:z_locations]
      @journey_route = data[:journey_route]
    end
  end
end
module Atco

  class Stop

    attr_accessor :bay_number, :location, :timing_point_indicator, :fare_stage_indicator, :published_arrival_time, :published_departure_time, :record_identity

    def origin?; @record_identity == "QO"; end
    def intermediate?; @record_identity == "QI"; end
    def destination?; @record_identity == "QT"; end
    
    def initialize(data)
      @bay_number = data[:bay_number]
      @location = data[:location]
      @timing_point_indicator = data[:timing_point_indicator]
      @fare_stage_indicator = data[:fare_stage_indicator]
      @published_departure_time = data[:published_departure_time]
      @published_arrival_time = data[:published_arrival_time]
      @record_identity = data[:record_identity]
    end

    def to_json(*args)
      {
        :record_identity => @record_identity,
        :location => @location,
        :published_departure_time => @published_departure_time,
        :timing_point_indicator => @timing_point_indicator,
        :fare_stage_indicator => @fare_stage_indicator,
        :bay_number => @bay_number
      }.to_json(*args)
    end
  end
end
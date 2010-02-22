module Atco
  
  class Journey
    
    attr_accessor :vehicle_type, :registration_number, :identifier, :operator, :route_number,
      :first_date_of_operation, :running_board, :last_date_of_operation, :school_term_time, :route_direction, :bank_holidays

    attr_accessor :stops

    def initialize(data)
      @mondays = parse_boolean_int data[:operates_on_mondays]
      @tuesdays = parse_boolean_int data[:operates_on_tuesdays]
      @wednesdays = parse_boolean_int data[:operates_on_wednesdays]
      @thursdays = parse_boolean_int data[:operates_on_thursdays]
      @fridays = parse_boolean_int data[:operates_on_fridays]
      @saturdays = parse_boolean_int data[:operates_on_saturdays]
      @sundays = parse_boolean_int data[:operates_on_sundays]
      
      @vehicle_type = data[:vehicle_type]
      @registration_number = data[:registration_number]
      @identifier = data[:unique_journey_identifier]
      @operator = data[:operator]
      @route_number = data[:route_number]
      @route_direction = data[:route_direction]
      @first_date_of_operation = data[:first_date_of_operation]
      @last_date_of_operation = data[:last_date_of_operation]
      @running_board = data[:running_board]
      @school_term_time = data[:school_term_time]
      @bank_holidays = data[:bank_holidays]
      
      @stops = []
     #stops.each do |s|
     #  @stops << Stop.new(s)
     #end
    end

    def mondays?; @mondays; end
    def tuesdays?; @tuesdays; end
    def wednesdays?; @wednesdays; end
    def thursdays?; @thursdays; end
    def fridays?; @fridays; end
    def saturdays?; @saturdays; end
    def sundays?; @sundays; end
    
    def parse_boolean_int(string)
      (string && string == "1") ? true : false
    end
    
    def to_json(*args)
      {
        :vehicle_type => @vehicle_type, 
        :registration_number => @registration_number, 
        :identifier => @identifier, 
        :operator => @operator, 
        :route_number => @route_number,
        :first_date_of_operation => @first_date_of_operation, 
        :running_board => @running_board, 
        :last_date_of_operation => @last_date_of_operation, 
        :school_term_time => @school_term_time, 
        :route_direction => @route_direction, 
        :bank_holidays => @bank_holidays,
        :stops => @stops
      }.to_json(*args)
    end
  end
end
require 'open3'
require 'tempfile'  
require 'atco/location'
require 'atco/journey'
require 'atco/stop'
require 'atco/journey_route'
require 'atco/journey_times'
require 'atco/z_location'
require 'atco/operator'
require 'atco/header'
require 'iconv'

module Atco
  VERSION = '0.0.1'
  
  class Parser
    
    def parse(file)
      path = File.expand_path(file)
      data = File.readlines(path)
      
      locations = []
      # journeys = []
      journey = nil
      header = nil
      z_journey = nil
      operator = nil
      journeys = nil
      # locations = []
      operators = []
      gmpte_info=[]
      first_line = data.first
      header = Header.new(parse_header first_line)
      data.each do |line|
        case line[0,2]
        when 'QS'
          journey = Journey.new(parse_journey_header line)
          z_journey.journeys << journey
        when 'QO'
          journey.stops << Stop.new(parse_origin line)
        when 'QP'
          #operator
          operator = Operator.new(parse_operator line)
          operators << operator
        when 'QQ'
          #additional operator info
          additional_operator_info = parse_additonal_operator_info line
          operator.address = additional_operator_info[:address]
        when 'QB'
          additional_info = parse_additional_location_info(line)
          location.easting = additonal_info[:grid_reference_easting]
          location.northing = additonal_info[:grid_reference_northing]
          location.short_code = additional_info[:location]
        when 'QL'
          location = Location.new(parse_location line)
          locations << location
        when 'QA'
          #alternative location
        when 'QH'
        when 'QI'
          journey.stops << Stop.new(parse_intermediate line)
        when 'QT'
          journey.stops << Stop.new(parse_destination line)
        when 'QO'
        when 'QR'
          #repetition records
        when 'ZD'
            #this is a gmpte specific thing
            #it's a new journey so start again
            #the assumption is that the journey record is defined before the stops etc
            # record_ended = false
            z_locations=[]
            z_journey = JourneyTimes.new(parse_journey_times line)
            z_journey.z_locations=z_locations
            z_journey.journey_identifiers = []
            journeys = []
            z_journey.journeys = journeys
            gmpte_info << z_journey
        when 'ZA'
            #this is a gmpte specific thing
            z_journey.z_locations << ZLocation.new(parse_stop_location_name line)
        when 'ZS'
            #this is a gmpte specific thing
            z_journey.journey_route = JourneyRoute.new(parse_journey_route line)
        end
      end
      
      return {:header => header, :locations => locations, :operators => operators, :journeys => journeys, :gmpte_info=>gmpte_info}
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
        :operator => parse_value(string[3,4]),
        :operator_short_form => parse_value(string[7,24]),
        :operator_legal_name => parse_value(string[31,48])
      }
    end
    
    def parse_additonal_operator_info
      {
        :record_identity => string[0,2],
        :address => string[77,3]
      }
    end
    
    def parse_additional_location_info(string)
      {
        :record_identity => string[0,2],
        :transaction_type => string[2,1],
        :location => string[3,12].strip,
        :grid_reference_easting => parse_value(string[15,8]),
        :grid_reference_northing => parse_value(string[23,8])
      }
    end
    
    def parse_location(string)
      {
        :record_identity => string[0,2],
        :transaction_type => string[2,1],
        :location => parse_value(string[3,12]),
        :full_location => parse_value(string[15,48]),
        :gazetteer_code => string[63,1]
      }
    end
    
    def parse_destination(string)
      {
        :record_identity => string[0,2],
        :location => string[2,12],
        :published_arrival_time => string[14,4],
        :bay_number => parse_value(string[18,3]),
        :timing_point_indicator => string[21,2],
        :fare_stage_indicator => string[23,2]
      }
    end
    
    def parse_intermediate(string)
      {
        :record_identity => string[0,2],
        :location => string[2,12],
        :published_arrival_time => string[14,4],
        :published_departure_time => string[18,4],
        :activity_flag => string[22,1],
        :bay_number => parse_value(string[23,3]),
        :timing_point_indicator => string[26,2],
        :fare_stage_indicator => string[28,2]
      }
    end
    
    def parse_origin(string)
      {
        :record_identity => string[0,2],
        :location => string[2,12],
        :published_departure_time => string[14,4],
        :bay_number => parse_value(string[18,3]),
        :timing_point_indicator => string[21,2],
        :fare_stage_indicator => string[23,2]
      }
    end
    # 
    def parse_journey_header(string)
      {
        :record_identity => string[0,2],
        :transaction_type => string[2,1],
        :operator => string[3,4].strip,
        :unique_journey_identifier => string[7,6],
        :first_date_of_operation => parse_value(string[13,8]),
        :last_date_of_operation => parse_value(string[21,8]),
        :operates_on_mondays => string[29,1],
        :operates_on_tuesdays => string[30,1],
        :operates_on_wednesdays => string[31,1],
        :operates_on_thursdays => string[32,1],
        :operates_on_fridays => string[33,1],
        :operates_on_saturdays => string[34,1],
        :operates_on_sundays => string[35,1],
        :school_term_time => parse_value(string[36,1]),
        :bank_holidays => parse_value(string[37,1]),
        :route_number => parse_value(string[38,4]),
        :running_board => parse_value(string[42,6]),
        :vehicle_type => parse_value(string[48,8]),
        :registration_number => parse_value(string[56,8]),
        :route_direction => string[64,1]
      }
    end
    # 
    def parse_value(value)
        return value.strip if value
    end
    
    #GMPTE has this data
    def parse_journey_times(string)
      {
        :record_identity => string[0,2],
        :start_time => string[2,8],
        :end_time => string[10,8],
        :days_of_the_week_text => parse_value(string[18,48])
      }
    end
    
    #GMPTE has this data
    def parse_journey_route(string)
      {
        :record_identity => string[0,2],
        :provider => string[2,8],
        :route_name => parse_value(string[10,4]),
        :route_text => parse_value(string[14,50])
      }
    end
    
    #GMPTE has this data
    def parse_stop_location_name(string)
      {
        :record_identity => string[0,2],
        :type => string[2,1],
        :identifier => parse_value(string[3,12]),
        :name => parse_value(string[14,48])
      }
    end
  end
  
end
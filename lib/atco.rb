# frozen_string_literal: true

require "open3"
require "tempfile"
require_relative "atco/header"
require_relative "atco/location"
require_relative "atco/journey"
require_relative "atco/stop"
require_relative "atco/version"

# Public: Atco is a module that provides a parser for the ATCO-CIF data format.
module Atco # rubocop:disable Metrics/ModuleLength
  class UnidentifiedRecordError < StandardError; end

  class << self # rubocop:disable Metrics/ClassLength
    @path = nil
    METHODS = {
      bank_holiday: "QH",
      operator: "QP",
      additional_location_info: "QB",
      location: "QL",
      destination: "QT",
      intermediate: "QI",
      origin: "QO",
      journey_header: "QS"
    }.freeze
    METHODS_BY_RECORD_IDENTITY = METHODS.invert.freeze

    def parse(file) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      @path = File.expand_path(file)
      data = File.readlines(@path)

      current_journey = nil
      current_location = nil
      locations = []
      journeys = {}
      header = nil
      unparsed = []

      data.each_with_index do |line, line_number| # rubocop:disable Metrics/BlockLength
        if line_number.zero?
          header = Header.parse(line)
          next
        end

        identifier = line[0, 2]
        method = METHODS_BY_RECORD_IDENTITY[identifier]

        begin
          raise UnidentifiedRecordError, "Unidentified record: #{identifier}" unless method

          object = send("parse_#{method}", line)
          next unless object[:record_identity] && object[:record_identity] == identifier

          case method
          when :journey_header
            current_journey = object
          when :location
            current_location = object
          when :additional_location_info
            locations << Location.new(current_location, object)
          end

          if current_journey
            if journeys[current_journey[:unique_journey_identifier]]
              journeys[current_journey[:unique_journey_identifier]].stops << Stop.new(object)
            else
              journeys[current_journey[:unique_journey_identifier]] = Journey.new(object)
            end
          end
        rescue UnidentifiedRecordError
          unparsed << { line: line, line_number: line_number }
          next
        end
      end
      { header: header, locations: locations, journeys: journeys, unparsed: unparsed }
    end

    def parse_bank_holiday(string)
      {
        record_identity: string[0, 2],
        transaction_type: string[2, 1],
        date_of_bank_holiday: string[3, 8]
      }
    end

    def parse_operator(string)
      {
        record_identity: string[0, 2],
        transaction_type: string[2, 1],
        operator: parse_value(string[3, 4]),
        operator_short_form: parse_value(string[7, 24]),
        operator_legal_name: parse_value(string[31, 48])
      }
    end

    def parse_additional_location_info(string)
      {
        record_identity: string[0, 2],
        transaction_type: string[2, 1],
        location: string[3, 12].strip,
        grid_reference_easting: parse_value(string[15, 8]),
        grid_reference_northing: parse_value(string[23, 8])
      }
    end

    def parse_location(string)
      {
        record_identity: string[0, 2],
        transaction_type: string[2, 1],
        location: parse_value(string[3, 12]),
        full_location: parse_value(string[15, 48]),
        gazetteer_code: string[63, 1]
      }
    end

    def parse_destination(string)
      {
        record_identity: string[0, 2],
        location: string[2, 12],
        published_arrival_time: string[14, 4],
        bay_number: parse_value(string[18, 3]),
        timing_point_indicator: string[21, 2],
        fare_stage_indicator: string[23, 2]
      }
    end

    def parse_intermediate(string)
      {
        record_identity: string[0, 2],
        location: string[2, 12],
        published_arrival_time: string[14, 4],
        published_departure_time: string[18, 4],
        activity_flag: string[22, 1],
        bay_number: parse_value(string[23, 3]),
        timing_point_indicator: string[26, 2],
        fare_stage_indicator: string[28, 2]
      }
    end

    def parse_origin(string)
      {
        record_identity: string[0, 2],
        location: string[2, 12],
        published_departure_time: string[14, 4],
        bay_number: parse_value(string[18, 3]),
        timing_point_indicator: string[21, 2],
        fare_stage_indicator: string[23, 2]
      }
    end

    def parse_journey_header(string) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      {
        record_identity: string[0, 2],
        transaction_type: string[2, 1],
        operator: string[3, 4].strip,
        unique_journey_identifier: string[7, 6],
        first_date_of_operation: parse_value(string[13, 8]),
        last_date_of_operation: parse_value(string[21, 8]),
        operates_on_mondays: string[29, 1],
        operates_on_tuesdays: string[30, 1],
        operates_on_wednesdays: string[31, 1],
        operates_on_thursdays: string[32, 1],
        operates_on_fridays: string[33, 1],
        operates_on_saturdays: string[34, 1],
        operates_on_sundays: string[35, 1],
        school_term_time: parse_value(string[36, 1]),
        bank_holidays: parse_value(string[37, 1]),
        route_number: parse_value(string[38, 4]),
        running_board: parse_value(string[42, 6]),
        vehicle_type: parse_value(string[48, 8]),
        registration_number: parse_value(string[56, 8]),
        route_direction: string[64, 1]
      }
    end

    def parse_value(value)
      value&.strip
    end
  end
end

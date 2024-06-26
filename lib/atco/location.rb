# frozen_string_literal: true

module Atco
  # Atco::Location is a data class to abstract ATCO-CIF Location records.
  class Location
    attr_accessor :name, :identifier, :easting, :northing, :gazeteer_code

    def initialize(location_header, additional_location_information)
      @name = location_header[:full_location]
      @identifier = location_header[:record_identity]
      @easting = additional_location_information[:grid_reference_easting]
      @northing = additional_location_information[:grid_reference_northing]
      @gazeteer_code = location_header[:gazetteer_code]
    end

    def to_json(*attrs)
      {
        name: @name,
        identifier: @identifier,
        easting: @easting,
        northing: @northing,
        gazeteer_code: @gazeteer_code
      }.to_json(*attrs)
    end
  end
end

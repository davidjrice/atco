# frozen_string_literal: true

module Atco
  # Atco::Header is a class to abstract ATCO-CIF Header data.
  class Header
    attr_accessor :file_type,
                  :version,
                  :file_originator,
                  :source_product,
                  :production_datetime

    # Public: Parse a header line from an ATCO-CIF file.
    # EXAMPLE:
    # "ATCO-CIF0500Electronic Registration         MIA 4.20.18     20090915113809\r\n"
    def self.parse(line)
      data = {
        file_type: line[0, 8],
        version: "#{line[8, 2].to_i}.#{line[10, 2].to_i}",
        file_originator: line[12, 32].strip!,
        source_product: line[44, 16].strip!,
        production_datetime: line[60, 14]
      }
      new(data)
    end

    def initialize(data)
      @file_type = data[:file_type]
      @version = data[:version]
      @file_originator = data[:file_originator]
      @source_product = data[:source_product]
      @production_datetime = data[:production_datetime]
    end

    def attributes
      {
        file_type: @file_type,
        version: @version,
        file_originator: @file_originator,
        source_product: @source_product,
        production_datetime: @production_datetime
      }
    end

    def to_json(*attrs)
      attributes.to_json(*attrs)
    end
  end
end

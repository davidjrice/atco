# frozen_string_literal: true

require "json"

RSpec.describe Atco do # rubocop:disable Metrics/BlockLength
  it "has a version number" do
    expect(Atco::VERSION).not_to be nil
  end

  it "should parse bank holiday" do
    expect(Atco.parse_bank_holiday("QHN20061225")).to eq(
      {
        record_identity: "QH",
        transaction_type: "N",
        date_of_bank_holiday: "20061225"
      }
    )
  end

  it "should parse operator" do
    expect(Atco.parse_operator("QPNTM  Translink Metro         Translink Metro           \r\n")).to eq(
      {
        record_identity: "QP",
        transaction_type: "N",
        operator: "TM",
        operator_short_form: "Translink Metro",
        operator_legal_name: "Translink Metro"
      }
    )
  end

  it "should parse additional location information" do
    expect(Atco.parse_additional_location_info("QBN700000001252  328622  367433      \r\n")).to eq(
      {
        record_identity: "QB",
        transaction_type: "N",
        location: "700000001252",
        grid_reference_easting: "328622",
        grid_reference_northing: "367433"
      }
    )
  end

  it "should parse location" do
    expect(Atco.parse_location("QLN700000001252Conway (River Rd)                               1\r\n")).to eq(
      {
        record_identity: "QL",
        transaction_type: "N",
        location: "700000001252",
        full_location: "Conway (River Rd)",
        gazetteer_code: "1"
      }
    )
  end

  # QT7000000012520605   T1F0
  it "should parse destination" do
    expect(Atco.parse_destination("QT7000000012520605   T1F0\r\n")).to eq(
      {
        record_identity: "QT",
        location: "700000001252",
        published_arrival_time: "0605",
        bay_number: "",
        timing_point_indicator: "T1",
        fare_stage_indicator: "F0"
      }
    )
  end

  it "should parse intermediate" do
    expect(Atco.parse_intermediate("QI70000000125607120712B   T1F0\r\n")).to eq(
      {
        record_identity: "QI",
        location: "700000001256",
        published_arrival_time: "0712",
        published_departure_time: "0712",
        activity_flag: "B",
        bay_number: "",
        timing_point_indicator: "T1",
        fare_stage_indicator: "F0"
      }
    )
  end

  it "should parse origin" do
    expect(Atco.parse_origin("QO7000000012520730   T1F0\r\n")).to eq(
      {
        record_identity: "QO",
        location: "700000001252",
        published_departure_time: "0730",
        bay_number: "",
        timing_point_indicator: "T1",
        fare_stage_indicator: "F0"
      }
    )
  end

  it "should parse journey header" do
    expect(Atco.parse_journey_header("QSNTM  13986520091005        1111100  9A  9018  0               I\r\n")).to eq(
      {
        record_identity: "QS",
        transaction_type: "N",
        operator: "TM",
        unique_journey_identifier: "139865",
        first_date_of_operation: "20091005",
        last_date_of_operation: "",
        operates_on_mondays: "1",
        operates_on_tuesdays: "1",
        operates_on_wednesdays: "1",
        operates_on_thursdays: "1",
        operates_on_fridays: "1",
        operates_on_saturdays: "0",
        operates_on_sundays: "0",
        school_term_time: "",
        bank_holidays: "",
        route_number: "9A",
        running_board: "9018",
        vehicle_type: "0",
        registration_number: "",
        route_direction: "I"
      }
    )
  end
end

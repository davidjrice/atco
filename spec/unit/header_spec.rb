# frozen_string_literal: true

RSpec.describe Atco::Header do
  before(:all) do
    line = "ATCO-CIF0500Electronic Registration         MIA 4.20.18     20090915113809\r\n"
    @header = Atco::Header.parse(line)
  end

  it "should be a Header object" do
    expect(@header).to be_a_kind_of(Atco::Header)
  end

  it "should parse header to attributes" do
    expect(@header.attributes).to eq(
      {
        file_type: "ATCO-CIF",
        version: "5.0",
        file_originator: "Electronic Registration",
        source_product: "MIA 4.20.18",
        production_datetime: "20090915113809"
      }
    )
  end

  it "should parse header to json" do
    expect(@header.to_json).to eq(
      "{\"file_type\":\"ATCO-CIF\",\"version\":\"5.0\",\"file_originator\":\"Electronic Registration\",\"source_product\":\"MIA 4.20.18\",\"production_datetime\":\"20090915113809\"}" # rubocop:disable Metrics/LineLength
    )
  end
end

# frozen_string_literal: true

RSpec.describe "with example.cif" do # rubocop:disable Metrics/BlockLength
  before(:all) do
    @atco = Atco.parse("spec/fixtures/translink-example.cif")
  end

  it "should parse header from fixture" do
    expect(@atco[:header].attributes).to eq(
      {
        file_type: "ATCO-CIF",
        file_originator: "Electronic Registration",
        source_product: "MIA 4.20.18",
        version: "5.0",
        production_datetime: "20090915113809"
      }
    )
  end

  it "should parse 1 journey" do
    expect(@atco[:journeys].size).to eq(1)
  end

  it "should parse journeys into Atco::Joruney objects" do
    expect(@atco[:journeys]["139748"]).to be_a_kind_of(Atco::Journey)
  end

  it "should parse 6 stops for journey 139748" do
    expect(@atco[:journeys]["139748"].stops.size).to eq(6)
  end

  it "should parse 2 locations" do
    expect(@atco[:locations].size).to eq(2)
  end

  it "should output file as JSON" do
    output = File.join(File.dirname(__FILE__), "..", "artefacts", "test.json")
    File.open(output, "w+") do |f|
      f.flush
      f.write(JSON.pretty_generate(@atco))
    end

    expect(File.exist?(output)).to be true

    data = File.read(output)
    json = JSON.parse(data)
    expect(json).to be_a(Hash)
  end

  it "should return 17 unparsed lines" do
    expect(@atco[:unparsed].size).to eq(17)
  end

  it "should not parse GS records" do
    expect(@atco[:unparsed][0]).to eq(
      {
        line: "GS00001433 N                    Belfast Metro Ops                                 7000\n",
        line_number: 3
      }
    )
  end

  it "should not parse GR records" do
    expect(@atco[:unparsed][1]).to eq(
      {
        line: "GR00001433Donegall Square East                                                                                7000\n", # rubocop:disable Layout/LineLength
        line_number: 4
      }
    )
  end
end

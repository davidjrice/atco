require File.dirname(__FILE__) + '/spec_helper'
require 'json'

describe Atco do
  
  before(:all) do
   
  end
  
  it "should output file for debugging!" do
    result = Atco.parse('spec/fixtures/example.cif')
    File.open('test.output', 'w+') do |f|
      f.flush
      f.write(JSON.pretty_generate(result))
    end
  end

  it "should parse header from fixture" do
    result = Atco.parse('spec/fixtures/example.cif')
    result[:header].should == {
      :file_type => "ATCO-CIF",
      :file_originator => "Electronic Registration",
      :source_product => "MIA 4.20.18",
      :version => "5.0",
      :production_datetime => "20090915113809"
    }
  end
  
  it "should parse locations from fixture" do
    result = Atco.parse('spec/fixtures/example.cif')
    result[:header].should == {
      :file_type => "ATCO-CIF",
      :file_originator => "Electronic Registration",
      :source_product => "MIA 4.20.18",
      :version => "5.0",
      :production_datetime => "20090915113809"
    }
  end
  
  it "should parse header" do
    Atco.parse_header("ATCO-CIF0500Electronic Registration         MIA 4.20.18     20090915113809\r\n").should == {
      :file_type => 'ATCO-CIF',
      :version => '5.0',
      :file_originator => 'Electronic Registration',
      :source_product => 'MIA 4.20.18',
      :production_datetime => '20090915113809'
    }
  end
  
  it "should parse bank holiday" do
    Atco.parse_bank_holiday("QHN20061225").should == {
      :record_identity => 'QH',
      :transaction_type => 'N',
      :date_of_bank_holiday => '20061225'
    }
  end
  
  it "should parse operator" do
    Atco.parse_operator("QPNTM  Translink Metro         Translink Metro           \r\n").should == {
      :record_identity => 'QP',
      :transaction_type => 'N',
      :operator => 'TM',
      :operator_short_form => 'Translink Metro',
      :operator_legal_name => 'Translink Metro'
    }
  end
  
  it "should parse additional location information" do
    Atco.parse_additional_location_info("QBN700000001252  328622  367433      \r\n").should == {
      :record_identity => 'QB',
      :transaction_type => 'N',
      :location => '700000001252',
      :grid_reference_easting => '328622',
      :grid_reference_northing => '367433'
    }
  end
  
  it "should parse location" do
    Atco.parse_location("QLN700000001252Conway (River Rd)                               1\r\n").should == {
      :record_identity => 'QL',
      :transaction_type => 'N',
      :location => '700000001252',
      :full_location => 'Conway (River Rd)',
      :gazetteer_code => '1'
    }
  end

  # QT7000000012520605   T1F0
  it "should parse destination" do
    Atco.parse_destination("QT7000000012520605   T1F0\r\n").should == {
      :record_identity => 'QT',
      :location => '700000001252',
      :published_arrival_time => '0605',
      :bay_number => "",
      :timing_point_indicator => 'T1',
      :fare_stage_indicator => 'F0'
    }
  end
  
  it "should parse intermediate" do
    Atco.parse_intermediate("QI70000000125607120712B   T1F0\r\n").should == {
      :record_identity => 'QI',
      :location => '700000001256',
      :published_arrival_time => '0712',
      :published_departure_time => '0712',
      :activity_flag => "B",
      :bay_number => "",
      :timing_point_indicator => 'T1',
      :fare_stage_indicator => 'F0'
    }
  end
  
  it "should parse origin" do
    Atco.parse_origin("QO7000000012520730   T1F0\r\n").should == {
      :record_identity => 'QO',
      :location => '700000001252',
      :published_departure_time => '0730',
      :bay_number => "",
      :timing_point_indicator => 'T1',
      :fare_stage_indicator => 'F0'
    }
  end

  it "should parse journey header" do
    Atco.parse_journey_header("QSNTM  13986520091005        1111100  9A  9018  0               I\r\n").should == {
      :record_identity => 'QS',
      :transaction_type => 'N',
      :operator => 'TM',
      :unique_journey_identifier => '139865',
      :first_date_of_operation => '20091005',
      :last_date_of_operation => '',
      :operates_on_mondays => '1',
      :operates_on_tuesdays => '1',
      :operates_on_wednesdays => '1',
      :operates_on_thursdays => '1',
      :operates_on_fridays => '1',
      :operates_on_saturdays => '0',
      :operates_on_sundays => '0',
      :school_term_time => '',
      :bank_holidays => '',
      :route_number => '9A',
      :running_board => '9018',
      :vehicle_type => '0',
      :registration_number => '',
      :route_direction => 'I'
    }
  end

  describe "with example.cif" do
    
    before(:all) do
      @atco = Atco.parse('spec/fixtures/example.cif')
    end
      
    it "should parse 1 journey" do
      @atco[:journeys].size.should == 1
    end
    
    it "should parse journeys into Atco::Joruney objects" do
      @atco[:journeys]["139748"].should be_a_kind_of(Atco::Journey)
    end

    it "should parse 6 stops for joureny 139748" do
      @atco[:journeys]["139748"].stops.size.should == 6
    end
    
    it "should parse 6 stops for joureny 139748" do
      @atco[:journeys]["139748"].stops.size.should == 6
    end
    
    it "should parse 2 locations" do
      @atco[:locations].size.should == 2
    end
    
  end
  

end
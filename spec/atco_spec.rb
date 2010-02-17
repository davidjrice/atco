require File.dirname(__FILE__) + '/spec_helper'
 
describe Atco do
  
  before(:all) do
   
  end
  
  it "should output file" do
    Atco.parse('SVRTMAO009A-20091005.cif')
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

  
end
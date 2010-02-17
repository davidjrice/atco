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
  
end
require 'spec_helper'

describe Volume do
  
  context "capacity" do
    
    it { should validate_presence_of(:capacity) }
    it { should_not allow_value("1").for(:capacity) }                           # missing units
    it { should_not allow_value("1KB").for(:capacity) }                         # invalid unit
    it { should_not allow_value("500Gb").for(:capacity) }                       # requires Bytes, not bits
    it { should allow_value("500GB").for(:capacity) }
    it { should allow_value("500 GB").for(:capacity) }
    it { should allow_value("2TB").for(:capacity) }
    
  end
  
  context "label" do
    
    before(:all) { Volume.create :label => "Test Volume", :capacity => "1TB" }  # required to verify uniqueness
    
    it { should validate_presence_of(:label) }
    it { should validate_uniqueness_of(:label) }
    it { should_not allow_value(" leading space").for(:label) }                 # must start with letter
    it { should_not allow_value("01 leading digit").for(:label) }               # must start with letter
    it { should_not allow_value("trailing space ").for(:label) }                # must end with letter
    it { should_not allow_value("Colby O'Donnis").for(:label) }                 # hypenation not allowed
    it { should allow_value("MiXeD cAsE").for(:label) }
    it { should allow_value("Johnny Walker").for(:label) }

    it "should be read-only" do
      v = Volume.create :label => "Foo Bar", :capacity => "1TB"
      v.update_attributes :label => "Something Else"
      v.reload
      v.label.should == "Foo Bar"
    end
    
  end
  
  context "name" do
    
    it "should include ID and Label" do
      v = Volume.create :label => "Rainbow Dash", :capacity => "1TB" do |m|
        m.id = 101                                                              # set a predictable ID
      end
      v.name.should match(/^\d{3}\s[A-Za-z][A-Za-z0-9\s]+[A-Za-z0-9]$/)         # "000 Volume Label"
      v.name.should == "101 Rainbow Dash"
    end
    
  end
  
end

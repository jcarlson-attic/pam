require 'spec_helper'

describe Volume do
  
  it { should validate_presence_of(:name) }
  it { should_not allow_value("Madonna").for(:name) }                           # no single names
  it { should_not allow_value("volume 1").for(:name) }                          # numbers not allowed
  it { should_not allow_value("John Wilkes Booth").for(:name) }                 # no triple names
  it { should_not allow_value("luke skywalker").for(:name) }                    # use proper capitalization
  it { should_not allow_value("Colby O'Donnis").for(:name) }                    # hypenation not allowed
  it { should allow_value("DeMar DeRozan").for(:name) }
  it { should allow_value("Johnny Walker").for(:name) }
  
  it { should validate_presence_of(:capacity) }
  it { should_not allow_value("1").for(:capacity) }                             # missing units
  it { should_not allow_value("1KB").for(:capacity) }                           # invalid unit
  it { should_not allow_value("500Gb").for(:capacity) }                         # requires Bytes, not bits
  it { should allow_value("500GB").for(:capacity) }
  it { should allow_value("500 GB").for(:capacity) }
  it { should allow_value("2TB").for(:capacity) }
  
  it { should validate_presence_of(:media_type) }
  
  it "should calculate an index from a valid name" do
    subject.name = "Abraham Lincoln"
    subject.index.should == "AL"
  end
  
  it "should validate uniqueness of the name's index" do
    v1 = Volume.new :name => "Abe Lincoln", :capacity => "3TB", :media_type => "hard drive"
    v2 = Volume.new :name => "Abe Lincoln", :capacity => "3TB", :media_type => "hard drive"
    
    v1.save.should be_true
    v2.save.should be_false
    
    v2.errors.should include(:name)
    v2.new_record?.should be_true
    
    v2.name = "Al Roker"
    v2.save.should be_true
  end
  
end

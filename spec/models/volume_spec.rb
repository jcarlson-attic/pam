require 'spec_helper'

describe Volume do
  
  it { should validate_presence_of(:name) }
  it { should_not allow_value(" leading space").for(:name) }                    # must start with letter
  it { should_not allow_value("01 leading digit").for(:name) }                  # must start with letter
  it { should_not allow_value("trailing space ").for(:name) }                   # must end with letter
  it { should_not allow_value("Colby O'Donnis").for(:name) }                    # hypenation not allowed
  it { should allow_value("MiXeD cAsE").for(:name) }
  it { should allow_value("Johnny Walker").for(:name) }
  
  it { should validate_presence_of(:capacity) }
  it { should_not allow_value("1").for(:capacity) }                             # missing units
  it { should_not allow_value("1KB").for(:capacity) }                           # invalid unit
  it { should_not allow_value("500Gb").for(:capacity) }                         # requires Bytes, not bits
  it { should allow_value("500GB").for(:capacity) }
  it { should allow_value("500 GB").for(:capacity) }
  it { should allow_value("2TB").for(:capacity) }
  
end

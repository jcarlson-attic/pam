class Volume < ActiveRecord::Base
  
  # TODO: Split capacity into capacity_size and capacity_units
  
  attr_readonly :name
  
  validates_presence_of :capacity
  validates_presence_of :name, :on => :create
  
  validates_format_of   :capacity,  :with => /^\d+\s?[GT]B$/
  validates_format_of   :name,      :with => /^[A-Za-z][A-Za-z0-9\s]+[A-Za-z0-9]$/,
                                    :on => :create
  
end

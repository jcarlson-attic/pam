class Volume < ActiveRecord::Base
  
  # TODO: Split capacity into capacity_size and capacity_units
  
  attr_readonly :label
  
  validates_presence_of   :capacity
  validates_presence_of   :label,     :on => :create
  
  validates_uniqueness_of :label,     :on => :create
  
  validates_format_of     :capacity,  :with => /^\d+\s?[GT]B$/
  validates_format_of     :label,     :with => /^[A-Za-z][A-Za-z0-9\s]+[A-Za-z0-9]$/,
                                      :on => :create
  
  def name
    "#{'%03d' % id} #{label}"
  end
  
end

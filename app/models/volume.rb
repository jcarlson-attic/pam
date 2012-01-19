class Volume < ActiveRecord::Base
  
  # TODO: Split capacity into capacity_size and capacity_units
  
  attr_readonly :name, :index
  
  # calculate the index value
  before_save :index!, :if => :new_record?
  before_save :validate_index, :if => :new_record?
  
  validates_presence_of :capacity
  validates_presence_of :media_type
  validates_presence_of :name, :on => :create
  
  validates_format_of   :capacity,  :with => /^\d+\s?[GT]B$/
  validates_format_of   :name,      :with => /^[A-Z][A-Za-z]+\s+[A-Z][A-Za-z]+$/,
                                    :on => :create
                                
  def index!
    idx = name.blank? ? nil : name.split.reduce("") {|m, n| m << n[0]}
    write_attribute :index, idx
  end
  
  def name=(value)
    write_attribute :name, value.to_s
    index!
  end
  
private
  
  def validate_index
    errors.add(:name, "must have a unique index") if self.class.where(:index => index).any?
    errors.empty?
  end
  
end

class Volume < ActiveRecord::Base
  
  STAGING_PATH = "/Users/jcarlson/Desktop/Staging"
  VOLUME_PATH = "/Users/jcarlson/Desktop/Volumes"
  
  # TODO: Split capacity into capacity_size and capacity_units
  
  attr_readonly :label
  
  after_save :create_staging_path!
  
  validates_presence_of   :capacity
  validates_presence_of   :label,     :on => :create
  validates_uniqueness_of :label,     :on => :create
  validates_format_of     :capacity,  :with => /^\d+\s?[GT]B$/
  validates_format_of     :label,     :with => /^[A-Za-z][A-Za-z0-9\s]+[A-Za-z0-9]$/,
                                      :on => :create
  
  def activate!
    previous.lock! unless previous.nil?
    `SetFile -a v "#{staging_path}"`
    
  end
  
  def name
    "#{'%03d' % id} #{label}"
  end
  
  def lock!
    raise "Allocate a new Volume before locking this one" if self.next.nil?
    `chmod -R a-w "#{staging_path}"`
    `chflags uchg "#{staging_path}"`
  end
  
  def next
    self.class.where("id > ?", id).order("id ASC").limit(1).first
  end
  
  def previous
    self.class.where("id < ?", id).order("id DESC").limit(1).first
  end
  
  def staging_path
    File.join STAGING_PATH, name
  end
  
private
  
  def create_staging_path!
    FileUtils.mkdir staging_path unless File.directory?(staging_path)
    `SetFile -a V "#{staging_path}"`
  end
  
end

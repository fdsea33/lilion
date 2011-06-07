class Petition < ActiveRecord::Base
  belongs_to :creator, :class_name=>"Person"
  belongs_to :updater, :class_name=>"Person"
  has_many :signatures, :dependent=>:delete_all
  has_many :valid_signatures, :class_name=>"Signature", :conditions=>{:locked=>false}, :order=>"created_at DESC"
  has_attached_file :logo, :styles => { :thumb => '50x50>', :small=>'100x100>', :normal=>'150x150' }

  validates_uniqueness_of :name
  validates_format_of :name, :with=>/^[a-z\-0-9]+$/
  validates_presence_of :title, :intro, :name, :sender, :commitment

  before_validation do
    self.active = true if self.published?
    self.name = self.title.to_s.parameterize if self.name.blank?
    self.name.gsub!(/[\s\_]+/, '-')
    self.sender = "no-reply@my-domain.tld" if self.sender.blank?
  end
  
  def to_param
    self.name
  end

  def signable?(signable_on = Time.now)
    self.published? and self.started_at <= signable_on and signable_on <= self.stopped_at
  end

end

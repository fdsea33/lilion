class Petition < ActiveRecord::Base
  belongs_to :creator
  belongs_to :updater
  has_many :signatures
  validates_uniqueness_of :name
  validates_format_of :name, :with=>/^[a-z\-0-9]$/

  before_validation do
    self.name.gsub!(/[\s\_]+/, '-')
  end
  
  def to_param
    self.name
  end

end

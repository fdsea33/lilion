class Signature < ActiveRecord::Base
  @@natures = ["madam", "sir", "company", "association", "other"]
  belongs_to :petition
  cattr_reader :natures
  validates_presence_of :number, :nature, :last_name, :email, :city
  validates_presence_of :first_name, :if=>Proc.new{|s| self.natures[0..1].include?(s.nature.to_s)}
  validates_inclusion_of :nature, :in=>@@natures, :if=>Proc.new{|s| !s.nature.blank?}
  validates_uniqueness_of :email, :number, :scope=>:petition_id

  def self.natures_hash
    hash = HashWithIndifferentAccess.new
    self.natures.each{|n| hash[I18n.translate("models.signature.natures.#{n}")] = n}
    return hash
  end

  before_validation(:on=>:create) do
    self.locked = true unless self.locked.is_a? FalseClass
    self.hashed_key = Person.give_password(64)
    self.signed_on = Date.today
    self.number = self.hashed_key
    self.language = I18n.locale.to_s
  end

  before_save(:on=>:create) do
    self.number = Person.give_password(8)
    until self.class.where(:petition_id=>self.petition_id, :number=>self.number).count.zero?
      self.number = Person.give_password(8)
    end
  end

  def human_nature
    I18n.translate("models.signature.natures.#{self.nature}")
  end

  def label
    "#{self.first_name} #{self.last_name}".strip
  end

  def to_param
    self.number
  end

end

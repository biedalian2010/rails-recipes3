class Event < ApplicationRecord

  belongs_to :category, :optional => true

  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

   validates_presence_of :name, :friendly_id                      #在name生效前,需执行friendly_id

   validates_uniqueness_of :friendly_id                          #friendly_id 必须保持唯一
   validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/  #格式只限小写英文数字及横线

   before_validation :generate_friendly_id, :on => :create
   has_many :tickets, :dependent => :destroy


 def to_param
   self.friendly_id
 end

 protected

 def generate_friendly_id
   self.friendly_id ||= SecureRandom.uuid
 end

end

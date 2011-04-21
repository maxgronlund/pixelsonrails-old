# encoding: utf-8
class Tutorial < ActiveRecord::Base
  has_many :tutorial_posts
  
  scope :language, lambda { where(:language => I18n.locale.to_s) }
  
    
  validates_presence_of :tutorial_type, :title
  
  TUTORIAL_TYPE = [['Illustrator', 'illustrator'],
              ['HaXe','HaXe'],
              ['Flash','flash'],
              ['Ruby on Rails','rubyonrails']]
    
end

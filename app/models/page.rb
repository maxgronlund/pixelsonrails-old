# encoding: utf-8
class Page < ActiveRecord::Base
  

  scope :language, lambda { where(:language => I18n.locale.to_s) }
  
  def self.with_identity(identity)
    where(:identity => identity).first
  end

  def self.welcome_dk 
    with_identity('welcome_dk ')
  end
  
  def self.welcome_en 
    with_identity('welcome_en')
  end
  
  def self.about_dk
    with_identity('about_dk')
  end
  
  def self.about_en
    with_identity('about_en')
  end
  
  define_index do
    indexes :title
    indexes :body
    indexes :language
  end
  
  
end

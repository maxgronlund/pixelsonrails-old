# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  
  #!!! if registerable is enabled all can signup and admin can't create accounts
  #!!! when registeerable is enabled links to signup has to be enabled
  
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :name, :image, :language
  has_many :blogs
  has_many :comments
  
  validates_presence_of :name
  
  has_attached_file :image, :styles => {  :micro => "24x28#",:small => "70x80#", :medium => "200x230#" }, :default_url => "/images/fallback/default_avatar_:style.png"
  
  validates_attachment_size :image, :less_than => 800.kilobytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg','image/jpg','image/png']
  
  
  ROLES = %w[member admin super]
  LANGUAGE = [['Dansk', 'dk'], ['English','en']]
  
  def admin_or_super?
    admin? || super?
  end
  
  def super?
    role == 'super'
  end
  
  def admin?
    role == 'admin'
  end
  
  def member?
    role == 'member'
  end
  
  
end

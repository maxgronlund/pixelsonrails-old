class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :grid,:password, :password_confirmation, :remember_me


  # Avatar image
  attr_accessible :image, :image_cache, :remote_image_url, :remove_image
  serialize :crop_params, Hash
  mount_uploader :image, AvatarUploader
  include ImageCrop


  # Roles etc
  attr_accessible :name, :role
  # validate :name, :presence => true
  
  ROLES = %w[member admin super]
  
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
    role == 'member' || role.nil? # Until role is set to :member by default
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  def is_first_user?
    id == 1
  end

end

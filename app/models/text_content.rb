class TextContent < ActiveRecord::Base
  validates :identity, :presence => true, :uniqueness => true
  validates_presence_of :title
  
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  
  
  def self.with_identity(identity)
    where(:identity => identity).first
  end

  def self.welcome 
    with_identity('welcome')
  end
  
end

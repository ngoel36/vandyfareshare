class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :phone, message: "Phone number required (only so your passengers can contact you. This will never be publicly displayed)."      
  validates_presence_of :name, message: "Name required. Otherwise no one would be willing to share a cab with you."
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@vanderbilt.edu$/i, message: "must be a Vandy email!"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone
  has_and_belongs_to_many :trips
  attr_accessible :name
end

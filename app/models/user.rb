class User < ActiveRecord::Base
  validates_presence_of :user_name, :email
  validates_uniqueness_of :user_name, :email, :case_sensitive => false

  devise :database_authenticatable, :registerable, :encryptable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :login, :user_name, :email, :password, :password_confirmation, :remember_me
  attr_accessor :login

  has_many :articles, :dependent => :nullify
  has_many :comments, :dependent => :nullify

  def admin?
    admin
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
end


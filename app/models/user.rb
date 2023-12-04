class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: {case_sensitive: true}, length: {minimum:5, maximum: 12}
  validates :password, presence: true, length: {minimum:8, maximum:15}
  validates :email, presence: true, uniqueness: {case_sensitive: true}
  validate :password_complexity
  has_many :cart_items, dependent: :destroy
  has_many :sales
  has_many :sale_items
  def self.ransackable_attributes(auth_object = nil)
    super & ['created_at', 'email', 'id', 'personal', 'remember_created_at', 'reset_password_sent_at', 'reset_password_token', 'updated_at', 'username']
  end

  private 

  def password_complexity 
    unless password =~ /^(?=.*[A-Za-z])(?=.*\d).+$/
      errors.add(:password, "La contraseña debe contener al menos una letra y un numero")
    end 
  end
  
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: {case_sensitive: true}, length: {minimum:5, maximum: 15}
  has_many :cart_items, dependent: :destroy
  has_many :sales
  has_many :sale_items
  def self.ransackable_attributes(auth_object = nil)
    super & ['created_at', 'email', 'id', 'personal', 'remember_created_at', 'reset_password_sent_at', 'reset_password_token', 'updated_at', 'username']
  end
end

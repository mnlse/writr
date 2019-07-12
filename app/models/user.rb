class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :ratings
  has_many :comments

  has_one :credit_card

  has_attached_file :avatar, styles: { small: "100x100>", medium: "300x300>", big: "600x600>", large: "1000x1000>" }
  has_attached_file :profile_background, styles: { medium: '1500x800>' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :profile_background, content_type: /\Aimage\/.*\z/

  has_many :friends

  before_create :set_privilege

  def full_name
    first_name + ' ' + last_name
  end
  
  private
  def set_privilege
    self.privilege = "user"
  end
end

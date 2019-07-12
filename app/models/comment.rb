class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :body, presence: true
  
  delegate :full_name, to: :user, prefix: true
  has_many :replies, class_name: :'Comment', foreign_key: :reply_to_id, dependent: :destroy
  has_many :ratings

  scope :replies_scope, -> { where(is_reply: true) }
  scope :no_replies, -> { where(is_reply: false) }
end

class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 3, maximum: 200 }
  validates :user_id, presence: true
  validates :article_id, presence: true

  default_scope -> { order(created_at: :desc) }

  belongs_to :article
  belongs_to :user
end

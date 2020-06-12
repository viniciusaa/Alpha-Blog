class Article < ApplicationRecord
  before_save :capitalize_title

  validates :title, presence: true, length: { minimum: 3, maximum: 35 },
                                    uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 10 }
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  # has_many :article_categories
  # has_many :categories, through: :article_categories

  def self.search(search)
    if !search.blank?
      where("title like ?", "%#{search}%")
    end
  end

  def capitalize_title
    self.title.capitalize!
  end
end

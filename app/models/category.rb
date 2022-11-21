class Category < ApplicationRecord
  belongs_to :user

  has_many :category_businesses, dependent: :destroy
  has_many :businesses, through: :category_businesses

  validates :icon, presence: true
  validates :name, presence: true
end

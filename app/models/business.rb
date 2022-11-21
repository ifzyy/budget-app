class Business < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_businesses, dependent: :destroy
  has_many :categories, through: :category_businesses

  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

class CategoryBusiness < ApplicationRecord
  belongs_to :category
  belongs_to :business
end

class CreateCategoryBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :category_businesses do |t|
      t.references :category, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true
      t.timestamps
    end
  end
end

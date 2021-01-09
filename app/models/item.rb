class Item < ApplicationRecord

  validates :name, :explanation, :category_id, :state_id, :burden_id, :prefecture_id, :day_id, :price, presence: true

  belongs_to :user
  # has_one :order

end
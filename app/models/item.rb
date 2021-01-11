class Item < ApplicationRecord

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :price, numericality: { only_integer: true, message: "Half-width number" }
    validates :category_id, numericality: { other_than: 1, message: 'Select' }
    validates :state_id, numericality: { other_than: 1, message: 'Select' }
    validates :burden_id, numericality: { other_than: 1, message: 'Select' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
    validates :day_id, numericality: { other_than: 1, message: 'Select' }
    end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range" }

  belongs_to :user
  # has_one :order

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :burden
  belongs_to :prefecture
  belongs_to :day

end
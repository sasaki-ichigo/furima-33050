class Item < ApplicationRecord

  validates :image, :name, :explanation, :price, presence: true

  validates :category_id, numericality: { other_than: 1, message: 'Select' }
  validates :state_id, numericality: { other_than: 1, message: 'Select' }
  validates :burden_id, numericality: { other_than: 1, message: 'Select' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
  validates :day_id, numericality: { other_than: 1, message: 'Select' }

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
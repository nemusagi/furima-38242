class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charge
  belongs_to :shippers_area
  belongs_to :shipment_date
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :name, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validates :category_id, :status_id, :shipping_charge_id, :shippers_area_id, :shipment_date_id, numericality: { other_than: 1 , message: "を入力してください"}
  validates :price, presence: true

  validates :price, numericality: {
    less_than_or_equal_to: 9999999 , greater_than_or_equal_to: 300,
    message: 'が設定範囲外です' 
  }
  validates :price, numericality: { message: 'は半角数字で入力してください'}
end

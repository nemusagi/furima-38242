class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charge
  belongs_to :shippers_area
  belongs_to :shipment_date
  belongs_to :user
  has_one_attached :image

  validates :name, :content, :image, presence: true
  validates :category_id, :status_id, :shipping_charge_id, :shippers_area_id, :shipment_date_id, numericality: { other_than: 1 , message: "can't be blank"}
  with_options presence: true, format: { with: /\A\d+\z/, message: 'is invalid. Input half-width characters'} do
    validates :price
  end

  validates :price, numericality: {
    less_than_or_equal_to: 9999999 , greater_than_or_equal_to: 300,
    message: 'is out of setting range' 
  }
end

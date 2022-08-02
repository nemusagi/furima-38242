class OrderForm
  include ActiveModel::Model

  attr_accessor :token, :postal_code, :prefecture_id, :city, :block, :building, :phone_number, :item_id, :user_id, :order_id

  with_options presence: true do
  validates :postal_code
  validates :city
  validates :block
  validates :phone_number
  validates :user_id
  validates :item_id
  validates :token
  end
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'input correctly'} 
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank" }
  validates :phone_number,  numericality: { message: 'Input only number' }
  validates :phone_number, length: { minimum: 10, maximum: 11 }

  def save

    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, block: block, building: building, 
      phone_number: phone_number,  order_id: order.id
    )
  end
end
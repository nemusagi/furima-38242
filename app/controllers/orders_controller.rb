class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [ :index, :create ]
  before_action :move_to_root
  def index
    @order_form = OrderForm.new

  end
  
  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end
  private
  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
  def set_item
    @item = Item.find(params[:item_id])
  end
  def move_to_root
    if  current_user.id ==  @item.user_id
      redirect_to  root_path
    elsif @item.order != nil
      redirect_to root_path
    end
  end
end

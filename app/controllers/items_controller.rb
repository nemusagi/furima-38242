class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  def index
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end   
  end
  
  private
  def item_params
    params.require(:item).permit(
      :name,  :content, :image, :category_id, :status_id, :shipping_charge_id, :shippers_area_id, :shipment_date_id, :price
    ).merge(user_id: current_user.id) 
  end

end

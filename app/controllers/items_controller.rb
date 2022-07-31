class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update ]
  before_action :move_to_index, only:  [ :edit, :update ]
  before_action :set_item, only: [:edit, :update ]
  def index
    @items =Item.order("created_at DESC")
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end   
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name,  :content, :image, :category_id, :status_id, :shipping_charge_id, :shippers_area_id, :shipment_date_id, :price
    ).merge(user_id: current_user.id) 
  end

  def set_item
    @item = Item.find(params[:id])
  end
  
  def move_to_index
    @item = Item.find(params[:id])
    unless  current_user.id ==  @item.user_id
      redirect_to action: :index
    end
  end
end

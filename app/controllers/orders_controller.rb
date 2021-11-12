class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
  end

  def new
    @item = Item.find(params[:item_id])
    @cart_address = CartAddress.new
  end

  def create
    @cart_address = CartAddress.new(cart_params)
    if @cart_address.valid?
      @cart_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def cart_params
    params.require(:cart_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end
end

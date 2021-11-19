class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :new, :create]

  def index
    @cart_address = CartAddress.new
    redirect_to root_path if current_user == @item.user
    redirect_to root_path if @item.cart.present?
  end

  def new
    @cart_address = CartAddress.new
  end

  def create
    @cart_address = CartAddress.new(cart_params)
    if @cart_address.valid?
      pay_item
      @cart_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def cart_params
    params.require(:cart_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: cart_params[:token],
      currency: 'jpy'
    )
  end
end

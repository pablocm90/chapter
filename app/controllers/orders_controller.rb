class OrdersController < ApplicationController

  def create
    topup = Topup.find(params[:topup_id])
    order  = Order.create!(topup_sku: topup.sku, amount: topup.price, state: 'pending')

    redirect_to new_order_payment_path(order)
  end

  def show
    @order = Order.where(state: 'paid').find(params[:id])
  end

end

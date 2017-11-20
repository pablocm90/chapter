class PaymentsController < ApplicationController
  before_action :set_order
  before_action :set_topup

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )
    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @order.amount_cents,
      description:  "Payment for Topup #{@order.topup_sku} for order #{@order.id}",
      currency:     @order.amount.currency
    )

    @order.update(payment: charge.to_json, state: 'paid')
    redirect_to order_path(@order)
    current_user.tokens += @topup.tokens
    current_user.save!

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_order_payment_path(@order)

  end

private

  def set_order
    @order = Order.where(state: 'pending').find(params[:order_id])
  end

  def set_topup
    @topup = Topup.where(sku: @order.topup_sku).first
  end
end

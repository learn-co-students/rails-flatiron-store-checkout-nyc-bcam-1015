class LineItemsController < ApplicationController
  before_action :initialize_cart, only: [:create]

  def create
    item = Item.find(params[:item_id])
    @line_item = current_cart.add_item(item.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_path(current_cart),
        notice: 'Item added to cart!' }
      else
        redirect_to store_path
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    price = @line_item.item.price
    respond_to do |format|
      format.html
      format.json do
        render json: { status: :ok, price: price }
      end
    end
  end
end

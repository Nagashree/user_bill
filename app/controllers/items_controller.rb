class ItemsController < ApplicationController
  def create
  	@item = Item.create(params[:item])
    if @item.save
      flash[:success] = "Item added!"
      redirect_to 'static_pages/show'
    else
      render 'static_pages/home'
    end
  end
end

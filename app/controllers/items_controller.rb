class ItemsController < ApplicationController
  def create
  	p "herere controller"
  	@item = Item.create(params[:item])
    if @item.save
      flash[:success] = "Item added!"
      redirect_to show_path
    else
      render 'static_pages/home'
    end
  end
  def destroy
    @item = Item.find(params[:id])
  	@item.destroy
    redirect_to show_path
  end
end

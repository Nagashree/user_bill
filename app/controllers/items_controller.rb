class ItemsController < ApplicationController
  def create
    #@bill = current_user.bills.build(params[:bill])
  	@item = Item.create(params[:item])
    if @item.save
      flash[:success] = "Item added!"
      redirect_to show_path
    else
      redirect_to show_path
    end
  end
  def destroy
    @item = Item.find(params[:id])
  	if @item.destroy
      flash[:success] = "Item removed"
    end
    redirect_to show_path
  end
end

class BillsController < ApplicationController
  def create
  	 @bill = current_user.bills.build(params[:bill])
  	 @bill.bill_date = 0.days.ago
    if @bill.save
      flash[:success] = "Bill created"
      redirect_to root_url
    else
      render show_path
    end
  end

  def destroy
    @bill = Bill.find(params[:id])
  	@bill.destroy
    redirect_to root_url
  end
end

class BillsController < ApplicationController
  def create
  	 @bill = current_user.bills.build(params[:bill])
  	 @bill.bill_date = Time.zone.today
    if @bill.save
      flash[:success] = "Bill created"
      redirect_to show_path
    else
      redirect_to show_path
    end
  end

  def destroy
    @bill = Bill.find(params[:id])
  	if @bill.destroy
      flash[:success] ="Bill deleted"
    end
    redirect_to show_path
  end
end

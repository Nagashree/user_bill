class StaticPagesController < ApplicationController
	before_filter :authenticate_user!, :only=> [:show]
	def home
		
	end
	def show
		@user=current_user
        @bills = current_user.bills.paginate(page: params[:page])
		@bill = current_user.bills.build if signed_in?
		@item = @bill.items.build if signed_in?
		#@items = @bills.items.paginate(page: params[:page])
	end
end

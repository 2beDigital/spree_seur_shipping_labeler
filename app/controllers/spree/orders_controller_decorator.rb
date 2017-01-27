Spree::OrdersController.class_eval do
	include Expeditions
	def show
		@order = Spree::Order.find_by_number!(params[:id])
		@delivery = return_expeditions if @order.shipments.first.shipping_method.name =~ /^Seur/ 
	end
end
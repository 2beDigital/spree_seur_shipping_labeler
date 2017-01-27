Spree::Admin::OrdersController.class_eval do
	include Expeditions
    def edit
    	can_not_transition_without_customer_info

        unless @order.completed?
          	@order.refresh_shipment_rates
		end
		@delivery = return_expeditions if @order.shipments.first.shipping_method.name =~ /^Seur/ 
		render :action => :edit
	end
end
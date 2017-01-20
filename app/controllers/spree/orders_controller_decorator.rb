Spree::OrdersController.class_eval do
	def show
		@order = Spree::Order.find_by_number!(params[:id])
		@order.shipments.each do |shipment|
			if shipment.seur_label
				@delivery_status = shipment.seur_label.generate_expedition('consulta_expediciones_str')					
			end
		end
	end
end
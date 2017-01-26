Spree::Admin::OrdersController.class_eval do
    def edit
    	can_not_transition_without_customer_info

        unless @order.completed?
          	@order.refresh_shipment_rates
		end
		@delivery = []
		@order.shipments.each do |shipment|
			if shipment.seur_label
				expeditions = shipment.seur_label.generate_expedition('consulta_listado_expediciones_str')	
				expeditions.expediciones.expedicion.each do |exp|
					if exp.remite_ref.text.upcase == shipment.number
						@delivery << exp
					end
				end
			end
		end	
		render :action => :edit
	end
end
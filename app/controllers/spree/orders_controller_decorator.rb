Spree::OrdersController.class_eval do
	include Expeditions
	def show_shipment_state
		@order = Spree::Order.find_by_number!(params[:id])
		@delivery = return_expeditions if has_seur_shipments?
		if @delivery.respond_to?('error')
		    flash[:error] = @delivery.error.descripcion.text.capitalize
		    render inline: "location.reload();"
		    return
		end
	end
end
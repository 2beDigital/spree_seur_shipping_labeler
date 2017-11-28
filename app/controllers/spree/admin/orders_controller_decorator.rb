Spree::Admin::OrdersController.class_eval do
	include Expeditions
	before_action :load_order, only: [:show_shipment_state, :edit, :update, :cancel, :resume, :approve, :resend, :open_adjustments, :close_adjustments, :cart]
	respond_to :js, :only => [:show_shipment_state]
    ssl_allowed :show_shipment_state
	def show_shipment_state
		@delivery = return_expeditions if has_seur_shipments?
		if @delivery.respond_to?('error') 
		    flash[:error] = @delivery.error.descripcion.text.capitalize
		    render inline: "location.reload();" 
		    return
		end
	end
end
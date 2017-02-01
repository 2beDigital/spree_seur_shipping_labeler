Spree::OrdersController.class_eval do
	include Expeditions
	def show
		@order = Spree::Order.find_by_number!(params[:id])
		@delivery = return_expeditions if has_seur_shipments?
	end
end
Spree::Admin::ShippingMethodsController.class_eval do
    respond_to :js, :only => [:show_tracking_shippings]
    ssl_allowed :show_tracking_shippings

	def show_tracking_shippings
		@delivery = generate_expedition    
		if @delivery.respond_to?('error') 
		    flash[:error] = @delivery.error.descripcion.text.capitalize
		    render inline: "location.reload();" 
		    return
		end
		set_deliveries
	end

	private

	def generate_expedition
      response  = expedition.process_request
      Nokogiri::Slop(response.body[:consulta_listado_expediciones_str_response][:out].downcase)
    end

    def expedition
      SpreeSeurShippingLabeler::ConsultExpedition.new(expeditons_params)
    end

	def set_deliveries
		expeditions = []
		if @delivery.expediciones.expedicion.count > 1
			@delivery.expediciones.expedicion.each do |expedition|
				expeditions << expedition
			end
		else
			expeditions << @delivery.expediciones.expedicion
		end
		@delivery = expeditions
	end

	def expeditons_params
		dates = { date_from: params[:date_from], date_to: params[:date_to] }
	end

end
module SpreeSeurShippingLabeler
  class ConsultExpedition
    require 'savon'

    attr_reader :params

    def initialize(number_reference, expedition)
      @params = SpreeSeurShippingLabeler::SeurConection.expedition_params
      @params[:num_exp] = number_reference
      @params[:expedition] = expedition.to_sym
    end

    # Sends post request to Seur web service and return the response
    def process_request
      client = Savon.client(wsdl: "https://ws.seur.com/webseur/services/WSConsultaExpediciones?wsdl", 
                            namespaces: { "xmlns:con" => "http://consultaExpediciones.servicios.webseur" }, 
                            namespace_identifier: :con, 
                            env_namespace: :soapenv, 
                            pretty_print_xml: true)
      
      # client.operations  => [:consulta_listado_expediciones_str, :consulta_detalle_expediciones_str, :consulta_expediciones_str, ... ]

      message = build_message_expedition
      request  = client.build_request(params[:expedition], message: message)
      response = client.call(params[:expedition], message: message)
      result = response, request
      rescue Savon::HTTPError => error
      Rails.logger.error error.http.code
      raise     
    end


    def build_message_expedition
      message =  {
        in0:  params[:type_exp] || 'S', # S => Salidas, L => Llegadas
        in1:  params[:num_exp] || '',
        in2:  params[:num_tracking] || '',
        in3:  params[:num_ref] || '',
        in4:  params[:seur_ccc],
        in5:  params[:date_from] || '',
        in6:  params[:date_to] || '',
        in7:  params[:situation] || '',
        in8:  params[:name_seller_customer] || '',
        in9:  params[:state_from_to] || '',
        in10: params[:seur_ecb] || '',
        in11: params[:change_service] || '0', # 0 => Unselected, 1 => Selected
        in12: params[:username],
        in13: params[:password],
        in14: params[:search_type] || 'S' # S => Public, N => Private
      }
    end
  end
end
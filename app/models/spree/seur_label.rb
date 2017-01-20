module Spree
  class SeurLabel < ActiveRecord::Base
    belongs_to :shipment
    
    has_one :order, through: :shipment

    belongs_to :shipping_box, class_name: 'Spree::Shipping::Box', foreign_key: 'spree_shipping_box_id'

    default_scope { order "created_at desc" }

    validates :tracking_number, presence: true 
    validates :print_label, presence: true

    def show_tracking_number
      self.tracking_number || 'No tracking number available'
    end

    def generate_label!
      # Generar etiqueta, tenemos que añadir los campos y realizar la request, obtener response y almacenar
      generated_label, request_xml = request.generate_label!

      if generated_label.body.has_key?(:impresion_integracion_pdf_con_ecbws_response)
        self.print_label     = generated_label.body[:impresion_integracion_pdf_con_ecbws_response][:out][:pdf]
        self.tracking_number = generated_label.body[:impresion_integracion_pdf_con_ecbws_response][:out][:ref_exped][:string]
      else
        self.print_label     = generated_label.body[:impresion_integracion_con_ecbws_response][:out][:traza]
        self.tracking_number = generated_label.body[:impresion_integracion_con_ecbws_response][:out][:ref_exped][:string]
      end
      self.response_xml    = generated_label.doc.to_xml
      self.request_xml     = Nokogiri::XML(request_xml.body)
    end

    def generate_expedition(params)
      response, request                             = expedition(params).process_request
      type_exp = (params + '_response').to_sym
      @delivery_status = {}
      @delivery_status[:error]                      = response.body[type_exp][:out].gsub(/[\n<>\/]/,' ') || ''
      # @delivery_status[:previo_num]               = response.body[type_exp][:out][:previo_num]
      # @delivery_status[:expedicion_num]           = response.body[type_exp][:out][:expedicion_num]
      # @delivery_status[:remite_ref]               = response.body[type_exp][:out][:remite_ref]
      # @delivery_status[:fecha_captura]            = response.body[type_exp][:out][:fecha_captura]
      # @delivery_status[:fecha_entrega]            = response.body[type_exp][:out][:f_real_entrega]
      # @delivery_status[:situacion_cod]            = response.body[type_exp][:out][:situacion_cod]
      # @delivery_status[:descripcion_para_cliente] = response.body[type_exp][:out][:descripcion_para_cliente]
      @delivery_status
    end

    def request
      Spree::ReturnRequest.new(self)
    end

    def expedition(params)
      SpreeSeurShippingLabeler::ConsultExpedition.new(self.tracking_number, params)
    end

  end
end

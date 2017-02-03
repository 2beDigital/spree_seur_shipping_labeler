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

    def generate_expedition
      response  = expedition.process_request
      Nokogiri::Slop(response.body[:consulta_listado_expediciones_str_response][:out].downcase)
    end

    def request
      Spree::ReturnRequest.new(self)
    end

    def expedition      
      SpreeSeurShippingLabeler::ConsultExpedition.new(expeditions_params)
    end

    private

    def expeditions_params
      dates = { date_from: (self.created_at - 7.days).strftime("%d-%m-%Y"), date_to: (self.created_at + 7.days).strftime("%d-%m-%Y") }
    end

  end
end

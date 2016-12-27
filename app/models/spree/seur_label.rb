module Spree
  class SeurLabel < ActiveRecord::Base
    after_create :generate_label!

    belongs_to :shipment
    
    has_one :order, through: :shipment

    belongs_to :shipping_box, class_name: 'Spree::Shipping::Box', foreign_key: 'spree_shipping_box_id'

    default_scope { order "created_at desc" }

    def show_tracking_number
      self.tracking_number || 'No tracking number available'
    end

    def generate_label!
      # Generar etiqueta, tenemos que añadir los campos y realizar la request, obtener response y almacenar
      # Para ello usaremos la libreria credentials.
      generated_label      = labeler
      self.print_label     = generated_label[:print_label]
      self.tracking_number = generated_label[:tracking_number]
      #self.request_xml     = generated_label[:request_xml]
      #self.response_xml    = generated_label[:response_xml]
      save!
    end

    def labeler
      SpreeSeurShippingLabeler::SeurShipment.label(self, self.order.ship_address) # le pasamos la etiqueta a crear
    end
  end
end
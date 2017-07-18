module Spree
  class ReturnRequest
    attr_reader :shipment, :order, :seur_label

    def initialize(label)
      @seur_label = label
      @shipment   = @seur_label.shipment
      @order      = @shipment.order
      self
    end

    def box
      seur_label.shipping_box
    end

    def height; box.height; end
    def length; box.length; end
    def width;  box.width;  end

    def total_weight
      calc_weight = shipment.inventory_units.flat_map(&:variant).sum(&:weight)
      calc_weight.zero? ? default_weight : calc_weight
    end

    def bundle_weight
      total_weight / bundle_number
    end

    def bundle_number
      seur_label.bundle_number
    end

    def return_filename
      "Return filename Goes Here"
    end

    def order_number
      order.number
    end

    def shipment_number
      shipment.number
    end

    def formatted_destination
      shipment.address.seur_formatted(order.email, order.special_instructions)
    end

    def formatted_origin
      order.shipments.first.stock_location.seur_formatted
    end

    def generate_label!
      labeler.process_request
    end

    def labeler
      SpreeSeurShippingLabeler::PickupLabel.new(self)
    end

    def default_weight
      1.0 * bundle_number # kg
    end

    def seur_type
      seur_label.shipping_seur_type
    end
  end
end

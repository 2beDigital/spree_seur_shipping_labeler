module Expeditions
  extend ActiveSupport::Concern

  def return_expeditions
    delivery = []
    @order.shipments.each do |shipment|
      if shipment.seur_label
        expeditions = shipment.seur_label.generate_expedition 
        expeditions.expediciones.expedicion.each do |exp|
          if exp.remite_ref.text.upcase == shipment.number
            delivery << exp
          end
        end
      end
    end 
    return delivery
  end
end
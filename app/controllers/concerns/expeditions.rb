module Expeditions
  extend ActiveSupport::Concern
  include Spree::Admin::OrdersHelper
  def return_expeditions
    delivery = []
    @order.shipments.each do |shipment|
      if shipment.seur_label
        expeditions = shipment.seur_label.generate_expedition 
        if expeditions.respond_to?('expediciones')
          expeditions.expediciones.expedicion.each do |exp|
            if exp.remite_ref.text.upcase == shipment.number
              delivery << exp
            end
          end
        end        
      end
    end 
    return delivery
  end
end
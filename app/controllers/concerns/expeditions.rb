module Expeditions
  extend ActiveSupport::Concern

  def return_expeditions
    delivery = []
    @order.shipments.each do |shipment|
      if shipment.seur_label
        expeditions = shipment.seur_label.generate_expedition 
        if expeditions.respond_to?('expediciones')
          expeditions.expediciones.expedicion.each do |exp|
            if exp.remite_ref.text.upcase == '53J163101570-ST'
              delivery << exp
            end
          end
        end        
      end
    end 
    return delivery
  end
  def has_seur_shipments?
    @order.shipments && @order.shipments.first.shipping_method && @order.shipments.first.shipping_method.admin_name.present? && @order.shipments.first.shipping_method.admin_name.downcase.include?('seur') 
  end
end
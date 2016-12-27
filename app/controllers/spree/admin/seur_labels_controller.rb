module Spree
  module Admin
    class SeurLabelsController < Spree::Admin::BaseController
      def show
        order = Spree::Order.where(number: params[:order_id]).first
        shipment = order.shipments.find(params[:shipment_id]) # Pendiente de parametro correcto
        label = shipment.seur_label

        send_data(label.pdf_text, type: 'application/pdf', disposition: 'inline')
      end
    end
  end
end
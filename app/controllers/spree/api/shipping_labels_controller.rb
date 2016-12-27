module Spree
  module Api
    class ShippingLabelsController < Spree::Api::BaseController
      before_filter :find_order

      def generate_seur_label
        @shipment  = @order.shipments.find_by(id: params[:shipment_id])
        @shipment.seur_labels = Spree::SeurLabel.new()
        @label = @shipment.seur_labels.create!(spree_shipping_box_id: params[:spree_shipping_box_id])

        redirect_to edit_admin_order_url(@order)
      end

      private
      def find_order
        @order = Spree::Order.where(number: params[:id]).first
      end
    end
  end
end

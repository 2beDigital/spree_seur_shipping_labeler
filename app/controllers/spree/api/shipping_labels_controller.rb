module Spree
  module Api
    class ShippingLabelsController < Spree::Api::BaseController
      before_filter :find_order

      def generate_seur_label
        @shipment = @order.shipments.find_by(number: params[:id])
        if @shipment.state != 'shipped'
          @label = @shipment.build_seur_label(spree_shipping_box_id: params[:spree_shipping_box_id], bundle_number: params[:bundle_number])
          @label.generate_label!  
          if @label.save
            flash[:success] = Spree.t(:label_success, number: @label.tracking_number)
          else
            flash[:error] = Spree.t(:label_error, error: @label.response_xml)        
          end
        else
          flash[:success] = Spree.t(:label_reload_success, number: @label.tracking_number)
        end
        redirect_to edit_admin_order_url(@order)
      end

      private
      def find_order
        @order = Spree::Order.where(number: params[:order_id]).first
      end
    end
  end
end

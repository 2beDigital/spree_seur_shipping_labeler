module Spree
  module Api
    class ShippingLabelsController < Spree::Api::BaseController
      before_action :find_order
      before_action :find_label, only: :generate_delivery_tracking
      respond_to :js, :only => [:generate_delivery_tracking]
      ssl_allowed :generate_delivery_tracking
      
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

      def generate_delivery_tracking
        if @label && @label.shipment.state == 'shipped'
          @delivery_status = @label.generate_expedition(params[:expedition])
        end
      end

      private

        def find_order
          @order = Spree::Order.where(number: params[:order_id]).first
        end

        def find_label
          @shipment = @order.shipments.find_by(number: params[:id])
          @label = @shipment.seur_label
        end
    end
  end
end

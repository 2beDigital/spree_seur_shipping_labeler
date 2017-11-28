Spree::Admin::OrdersHelper.module_eval do
  def has_seur_shipments?
    @order.shipments.present? && @order.shipments.first.shipping_method.present? && @order.shipments.first.shipping_method.admin_name.present? && @order.shipments.first.shipping_method.admin_name.downcase.include?('seur')
  end
end

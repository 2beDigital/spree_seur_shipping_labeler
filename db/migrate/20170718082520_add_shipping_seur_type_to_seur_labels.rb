class AddShippingSeurTypeToSeurLabels < ActiveRecord::Migration
  def change
  	add_reference :spree_seur_labels, :spree_shipping_seur_types, index: true
  end
end

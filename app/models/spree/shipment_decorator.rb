Spree::Shipment.class_eval do
  has_one :seur_labels, class_name: "Spree::SeurLabel"
end
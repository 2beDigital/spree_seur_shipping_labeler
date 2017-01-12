Spree::Shipment.class_eval do
  has_one :seur_label, class_name: "Spree::SeurLabel"
end
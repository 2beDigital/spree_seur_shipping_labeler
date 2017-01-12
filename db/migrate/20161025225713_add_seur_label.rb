class AddSeurLabel < ActiveRecord::Migration
  def change
    create_table :spree_seur_labels, :force => true do |t|
      t.belongs_to :order
      t.belongs_to :shipment   
      t.belongs_to :spree_shipping_box
      t.decimal    :weight,                  precision: 8, scale: 2
      t.integer    :bundle_number,           default: 1
      t.text       :request_xml,             limit: 4294967295
      t.text       :response_xml,            limit: 4294967295
      t.text       :print_label,             limit: 4294967295
      t.string     :tracking_number
      t.datetime   :created_at,              null: false
      t.datetime   :updated_at,              null: false
    end

    add_index :spree_seur_labels, [:shipment_id], name: :idx_spree_seur_shipping_labels
  end
end

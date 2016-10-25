class AddSeurLabel < ActiveRecord::Migration
  def change
    create_table "spree_seur_labels", :force => true do |t|
      t.belongs_to :spree_shipments
      t.belongs_to :spree_shipping_box
      t.decimal  "weight",             precision: 8, scale: 2
      t.text     "request_xml",
      t.text     "response_xml",
      t.text     "print_label",
      t.string   "tracking_number",
      t.datetime "created_at",                                       :null => false
      t.datetime "updated_at",                                       :null => false
    end

    add_index :spree_seur_labels, [:seur_authorization_id], name: :idx_spree_seur_shipping_labels
  end
end

class AddShippingBoxes < ActiveRecord::Migration
  def change
    create_table "spree_shipping_boxes", :force => true do |t|
      t.string   "description",                :null => false
      t.integer  "bulges",      :default => 1, :null => false
      t.integer  "length",      :default => 0, :null => false
      t.integer  "width",       :default => 0, :null => false
      t.integer  "height",      :default => 0, :null => false
      t.datetime "created_at",                 :null => false
      t.datetime "updated_at",                 :null => false
    end

    add_index "spree_shipping_boxes", ["description"], :name => "idx_shipping_boxes_on_description", :unique => true
  end
end

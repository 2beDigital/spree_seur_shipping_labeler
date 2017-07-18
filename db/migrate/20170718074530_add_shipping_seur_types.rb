class AddShippingSeurTypes < ActiveRecord::Migration
   def change
    create_table :spree_shipping_seur_types, :force => true do |t|
      t.string   :name,                   null: false
      t.integer  :service,                null: false
      t.integer  :product,                null: false
      t.datetime :created_at,             null: false
      t.datetime :updated_at,             null: false
    end

    add_index :spree_shipping_seur_types, [:name], :name => :idx_shipping_seur_types_on_name, :unique => true
  end
end

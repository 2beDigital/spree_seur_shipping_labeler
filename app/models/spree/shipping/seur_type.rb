module Spree
  module Shipping
    class SeurType < ActiveRecord::Base
      self.table_name = "spree_shipping_seur_types"

      validates_uniqueness_of :name, case_sensitive: false

    end
  end
end
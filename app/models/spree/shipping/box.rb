module Spree
  module Shipping
    class Box < ActiveRecord::Base
      self.table_name = "spree_shipping_boxes"

      has_many :packages

      validates_uniqueness_of :description, case_sensitive: false

      def self.preferred_for_returns
        first
      end
    end
  end
end

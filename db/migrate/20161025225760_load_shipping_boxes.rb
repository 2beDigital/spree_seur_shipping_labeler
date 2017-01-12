class LoadShippingBoxes < ActiveRecord::Migration
  def up
    SpreeSeurShippingLabeler::Engine.load_seed
  end
end

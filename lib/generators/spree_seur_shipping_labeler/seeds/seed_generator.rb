module SpreeSeurShippingLabeler
  module Generators
    class SeedGenerator < Rails::Generators::Base
      desc "Create default shipping boxes"
      def run_db_seeds
        seed_file = File.join(File.expand_path("../../../../db", __FILE__), "seeds.rb")
        load(seed_file) if File.exist?(seed_file)
      end
    end
  end
end
require 'spree_seur_shipping_labeler/helpers'

module SpreeSeurShippingLabeler
  class Credentials

    include Helpers
    attr_reader :username, :password, :seur_printer, :seur_printer_model,
                :seur_ecb_code, :seur_franchise, :seur_id

    def initialize(options={})
      requires!(options, :username, :password, :seur_franchise, :seur_id)
      @username = options[:username]
      @password = options[:password]
      @seur_printer_model = options[:seur_printer_model]
      @seur_ecb_code = options[:seur_ecb_code]
      @seur_franchise = options[:seur_franchise]
      @seur_id = options[:seur_id]
    end

  end
end
require 'spree_seur_shipping_labeler/seur_helper'

module SpreeSeurShippingLabeler
  class SeurConection
    include SeurHelper
    attr_accessor :params

    def self.config params
      requires!(params, :username,
                        :password,
                        :seur_printer, 
                        :seur_printer_model, 
                        :seur_ecb_code, 
                        :seur_franchise, 
                        :seur_id, 
                        :username_exp, 
                        :password_exp, 
                        :ccc_exp)
      requires!(params[:bundle], :ci, :nif, :ccc)
      @params = params
    end

    def self.connection_params
      raise "SpreeSeurShippingLabeler not configured!" if @params.nil?
      @params
    end

    def self.connection_bundle
      connection_params.fetch(:bundle)
    end

    def self.credentials
      connection_params.except(:bundle)
    end

    def self.expedition_params
      params = connection_params
      data = {username: params[:username_exp], password: params[:password_exp], ccc_exp: params[:ccc_exp]}
    end

    private

    def self.requires!(hash, *params)
      params.each { |param| raise RateError, "Missing Required Parameter #{param}" if hash[param].nil? }
    end

  end
end

require 'spree_seur_shipping_labeler/seur_helper'

module SpreeSeurShippingLabeler
  class SeurConection
    include SeurHelper
    attr_accessor :params

    def self.config params
      requires!(params, :username, :password, :seur_printer, :seur_printer_model, :seur_ecb_code, :seur_franchise, :seur_id)
      requires!(params[:bundle], :ci, :nif, :ccc, :service, :product)
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
      data = {username: params[:username], password: params[:password], seur_ccc: params[:bundle][:ccc]}
    end

    private

    def self.requires!(hash, *params)
      params.each { |param| raise RateError, "Missing Required Parameter #{param}" if hash[param].nil? }
    end

  end
end
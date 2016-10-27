module SpreeSeurShippingLabeler
  class PickupLabel
    require 'savon'

    include Helpers

    require 'savon'



    def initialize(credentials, options={})
      requires!(options,  :vat)
      @credentials = credentials
      @address = options[:address]
      @order = options[:order]
      @vat = options[:vat]
      @mode = credentials.seur_printer_model
    end




    # Sends post request to Seur web service and return the response
    def process_request
      client = Savon.client(wsdl: "http://cit.seur.com/CIT-war/services/ImprimirECBWebService?wsdl", pretty_print_xml: true)
      client.operations  # => [:impresionIntegracionPDFConECBWS, :impresionIntegracionConECBWS]

      if @mode.blank?
        operation = :impresionIntegracionPDFConECBWS
        message = build_messagePDF
      else
        operation = :impresionIntegracionConECBWS
        message = build_messageECB
      end

      response = client.call(operation, message: message)
      rescue Savon::HTTPError => error
      Logger.log error.http.code
      raise
    end


    def build_messageECB

    end

    def build_messagePDF

    end

    def build_

  end
end

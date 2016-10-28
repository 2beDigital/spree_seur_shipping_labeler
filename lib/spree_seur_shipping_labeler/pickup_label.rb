module SpreeSeurShippingLabeler
  class PickupLabel
    require 'savon'

    include Helpers

    require 'savon'


    def initialize(credentials, options={})
      requires!(options,  :vat, :bundle)
      @credentials = credentials
      @address = options[:address]
      @order = options[:order]
      @vat = options[:vat]
      @franchise = options[:franchise]
      @mode = credentials.seur_printer_model


      @bundle = options[:bundle]
      @bundle_number = options[:bundle_number]
      @bundle_message = bundle_vals(options)

      @order = option[:order]
      @shipment = option[:shipment]
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

      client.call(operation, message: message)
      rescue Savon::HTTPError => error
      Logger.log error.http.code
      raise
    end


    def build_messageECB
      #TODO ECB
    end

    def build_messagePDF
      #TODO ECB PDF
    end

    def build_message
      # Example http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder
      Nokogiri::XML::Builder.new(:encoding => 'ISO-8859-1') do |xml|
          xml.root {
            xml.products {
              xml.widget {
                xml.id_ '10'
                xml.name 'Awesome widget'
              }
            }
          }
      end
    end

    def bundle_vals(options)
      {
          ci: options[:bundles],
          ccc: options[:ccc],
          servicio: options[:service],
          product: options[:product] || 2,
          total_bultos: @bundle_number,
          total_kilos: @bundle_number*@bundle.weight,
          peso_bulto:  @bundle.weight,
          observaciones: '',
          referencia_expedicion: @shipment.number,
          ref_bulto: @shipment.number,
          clave_portes: options[:clave_portes] || 'F', # F: Facturacion
          clave_reembolso: options[:clave_reembolso] || 'F', # F: Facturacion
          valor_reembolso: options[:valor_reembolso] || '',
          cliente_nombre: options[:cliente_nombre] || '',
          cliente_direccion: options[:cliente_direccion] || '',
          cliente_tipovia: options[:cliente_tipovia] || 'CL',
          cliente_tnumvia: options[:cliente_tnumvia] || 'N',
          cliente_numvia: options[:cliente_numvia] || '.',
          cliente_escalera: options[:cliente_escalera] ||  '.',
          cliente_piso: options[:cliente_piso] || '.',
          cliente_puerta: options[:cliente_puerta] || '',
          cliente_poblacion: options[:cliente_poblacion] || '',
          cliente_cpostal: options[:cliente_cpostal] || '',
          cliente_pais: options[:cliente_pais] || '',
          cliente_email: options[:cliente_email] || '',
          cliente_telefono: options[:cliente_telefono] || '',
          cliente_atencion: options[:cliente_atencion] || ''
      }
    end

  end
end

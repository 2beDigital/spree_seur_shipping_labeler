module SpreeSeurShippingLabeler
  class PickupLabel
    require 'savon'

    attr_reader :package, :credentials, :bundle, :customer_address, :seller_address

    def initialize(pkg=nil)
      @package = pkg
      @customer_address = @package.formatted_destination
      @seller_address = @package.formatted_origin
      @credentials = SpreeSeurShippingLabeler::SeurConection.credentials
      @bundle = SpreeSeurShippingLabeler::SeurConection.connection_bundle
    end

    # Sends post request to Seur web service and return the response
    def process_request
      client = Savon.client(wsdl: "http://cit.seur.com/CIT-war/services/ImprimirECBWebService?wsdl", 
                            namespaces: { "xmlns:imp" => "http://localhost:7026/ImprimirECBWebService" }, 
                            namespace_identifier: :imp, 
                            env_namespace: :soapenv, 
                            pretty_print_xml: true)
      
      # client.operations  => [:impresion_integracion_pdf_con_ecbws, :impresion_integracion_con_ecbws]

      if credentials[:seur_printer].blank?
        operation = :impresion_integracion_pdf_con_ecbws
        message = build_messagePDF
      else
        operation = :impresion_integracion_con_ecbws
        message = build_messageECB
      end

      request  = client.build_request(operation, message: Gyoku.xml(message))
      response = client.call(operation, message: Gyoku.xml(message))
      result = response, request
      rescue Savon::HTTPError => error
      Rails.logger.error error.http.code
      raise     
    end


    def build_messageECB
      tmp = Nokogiri::XML::Document.new
      message =  {
        in0:  credentials[:username],
        in1:  credentials[:password],
        in2:  credentials[:seur_printer],
        in3:  credentials[:seur_printer_model],
        in4:  credentials[:seur_ecb_code],
        in5!: tmp.create_cdata(build_message.doc.to_xml).to_s.gsub('UTF-8','ISO-8859-1'), # Exclamation (in5!:) needed for escape cdata with Gyoku
        in6:  'fichero_' + Time.now.to_i.to_s + '.xml',
        in7:  bundle[:nif],
        in8:  credentials[:seur_franchise],
        in9:  '-1' ,
        in10: seller_address[:company]
      }
    end

    def build_messagePDF
      tmp = Nokogiri::XML::Document.new
      message = {
        in0:  credentials[:username],
        in1:  credentials[:password],
        in2!: tmp.create_cdata(build_message.doc.to_xml).to_s.gsub('UTF-8','ISO-8859-1'), # Exclamation (in2!:) needed for escape cdata with Gyoku
        in3:  'fichero_' + Time.now.to_i.to_s + '.xml',
        in4:  bundle[:nif] ,
        in5:  credentials[:seur_franchise] ,
        in6:  '-1' ,
        in7:  seller_address[:company]
      }
    end

    def build_message
      # Example http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder
      bundles = {}
      Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.root {
            xml.exp {
              package.bundle_number.times do |i|
                xml.bulto {            
                    bundles = bundle_vals(i+1)
                    bundles.each do |key, value|
                      xml.send(key, value)
                    end
                }
              end
            }
          }
      end
    end

    def bundle_vals(index_bundle)
      bundles = {
          ci: bundle[:ci],
          nif: bundle[:nif],
          ccc: bundle[:ccc],
          servicio: bundle[:service],
          producto: bundle[:product] || 2,
          total_bultos: package.bundle_number,
          total_kilos: package.total_weight, # number of bundle * weight of bundle
          pesoBulto:  package.bundle_weight,
          observaciones: customer_address[:instructions] || '',
          referencia_expedicion: package.shipment_number,
          ref_bulto: package.shipment_number.to_s + '-' + index_bundle.to_s,
          largo_bulto: package.length || '',
          ancho_bulto: package.width || '',
          alto_bulto: package.height || '',
          clavePortes: bundle[:clave_portes] || 'F', # F: Facturacion
          claveReembolso: bundle[:clave_reembolso] || 'F', # F: Facturacion
          valorReembolso: bundle[:valor_reembolso] || '',
          nombre_remit: seller_address[:company],
          nombrevia_remit: seller_address[:address],
          numvia_remit: '',
          codpos_remit: seller_address[:zip_code],
          poblacion_remit: seller_address[:state],
          telefono_remit: seller_address[:phone_number],
          nombre_consignatario: customer_address[:name] || '',
          direccion_consignatario: customer_address[:address] || '',
          tipoVia_consignatario: 'CL',
          tNumVia_consignatario: 'N',
          numvia_consignatario: '',
          escalera_consignatario: '',
          piso_consignatario: '',
          puerta_consignatario: '',
          poblacion_consignatario: customer_address[:city] || '',
          codPostal_consignatario: customer_address[:zip_code] || '',
          email_consignatario: customer_address[:email]  || '',
          pais_consignatario: customer_address[:country_iso] || '',
          test_email: 'N',
          test_preaviso: 'N',
          test_reparto: 'N',
          telefono_consignatario: customer_address[:phone_number]  || '',
          cod_centro: '',
          codigo_pais_origen: seller_address[:country_iso],
          id_mercancia: ''
      }
    end
  end
end
# Use this initializer to configure Seur

SpreeSeurShippingLabeler.setup do |config|

  # Seur Servicios
  # '001': 'SEUR - 24',
  # '003': 'SEUR - 10',
  # '005': 'MISMO DIA',
  # '007': 'COURIER',
  # '009': 'SEUR 13:30',
  # '013': 'SEUR - 72',
  # '015': 'S-48',
  # '017': 'MARITIMO',
  # '019': 'NETEXPRESS',
  # '077': 'CLASSIC',
  # '083': 'SEUR 8:30',
  config.bundle = {
    ci:            ENV["seur_bundle_ci"],
    nif:           ENV["seur_bundle_nif"],
    ccc:           ENV["seur_bundle_ccc"],
    service:       ENV["seur_bundle_service"],
    product:       ENV["seur_bundle_product"]
  }

  config.in0.username = ENV["seur_username"],
  config.in1.password = ENV["seur_password"],

  # ImpresionIntegracionConECBWS
  config.ConECBWS.in2.printer = ENV["seur_printer"]
  config.ConECBWS.in3.printer_model = ENV["seur_printer_model"]
  config.ConECBWS.in4.ecb_code = ENV["seur_ecb_code"]

  config.franchise = ENV["seur_franchise"],
  config.seurid    = ENV["seur_id"]

end
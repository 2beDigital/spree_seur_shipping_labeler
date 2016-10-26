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
    ci:             ENV["bundle_ci"],
    nif:            ENV["bundle_nif"],
    ccc:            ENV["bundle_ccc"],
    service:       ENV["bundle_service"],
    product:       ENV["bundle_product"]
  }

  config.in0.username = ENV["in0_username"],
  config.in1.password = ENV["in1_password"],

  # ==> impresionIntegracionConECBWS
  config.ConECBWS.in2.printer = ENV["ConECBWS_in2_printer"]
  config.ConECBWS.in3.printer_model = ENV["ConECBWS_in3_printer_model"]
  config.ConECBWS.in4.ecb_code = ENV["ConECBWS_in4_ecb_code"]

  config.franchise = ENV["imp_franchise"],
  config.seurid    = ENV["imp_seurid"]

end
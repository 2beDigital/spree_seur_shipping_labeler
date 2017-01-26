# Set principals configuration to SpreeSeurShippingLabeler
seur_config = YAML.load_file("config/seur_api.yml")[Rails.env]

SpreeSeurShippingLabeler::SeurConection.config({
  username:           seur_config["username"],
  password:           seur_config["password"], 
  seur_printer:       seur_config["seur_printer"], 
  seur_printer_model: seur_config["seur_printer_model"],
  seur_ecb_code:      seur_config["seur_ecb_code"],
  seur_franchise:     seur_config["seur_franchise"],
  seur_id:            seur_config["seur_id"],
  username_exp:       seur_config["username_exp"],
  password_exp:       seur_config["password_exp"],
  ccc_exp:            seur_config["ccc_exp"],
  bundle:             {
                        ci:            seur_config["seur_bundle_ci"],
                        nif:           seur_config["seur_bundle_nif"],
                        ccc:           seur_config["seur_bundle_ccc"],
                        service:       seur_config["seur_bundle_service"],
                        product:       seur_config["seur_bundle_product"]
                      }
})
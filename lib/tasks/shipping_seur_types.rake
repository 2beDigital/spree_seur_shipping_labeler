namespace :shipping_seur_types do
  	desc "Create shipping seur types"
	task create: :environment do
	  	puts "Create shipping seur types"

		seur_shippings = [['Nacional Estandar',         '31', '2' ],
		                  ['Nacional Seur24',           '31', '1' ],
		                  ['Internacional Classic',     '70', '77'],
		                  ['Internacional Net Express', '70', '19'],
		                  ['Internacional Courier',     '70', '79'],
		                  ['Internacional Cargo',       '70', '7' ]]

		seur_shippings.each do |name, service, product|
		  type = Spree::Shipping::SeurType.where(
		    name: name,
		    service: service,
		    product: product).first_or_create!

		  puts "Ensured existence of seur shippings types #{type.name}"
		end
	end
end
namespace :shipping_seur_types do
  	desc "Create shipping seur types"
	task create: :environment do
	  	puts "Create shipping seur types"

		seur_shippings = [['Nacional Estandar',         '31', '2' ],
		                  ['Nacional Seur24',           '1' , '2' ],
		                  ['Internacional Classic',     '77', '70'],
		                  ['Internacional Net Express', '19', '70'],
		                  ['Internacional Courier',     '79', '70'],
		                  ['Internacional Cargo',       '7' , '70']]

		seur_shippings.each do |name, service, product|
		  type = Spree::Shipping::SeurType.where(
		    name: name,
		    service: service,
		    product: product).first_or_create!

		  puts "Ensured existence of seur shippings types #{type.name}"
		end
	end
end
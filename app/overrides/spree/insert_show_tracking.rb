Deface::Override.new(virtual_path: 'spree/orders/show',
					 name: 'insert_show_tracking',
					 insert_before: 'p[data-hook="links"]',
					 partial: 'spree/shared/show_shipping_status')
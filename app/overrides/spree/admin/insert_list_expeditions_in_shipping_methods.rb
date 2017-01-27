Deface::Override.new(virtual_path: 'spree/admin/shipping_methods/index',
					 name: 'insert_list_expeditions_in_shipping_methods',
					 insert_after: 'table#listing_shipping_methods',
					 text: "<fieldset>
							    <legend><%= Spree.t(:show_tracking_status) %></legend>
							      <%= form_tag show_tracking_shippings_admin_shipping_methods_path, url:  show_tracking_shippings_admin_shipping_methods_path, method: :post, remote: true, id: 'show-tracking-shippings' do |f| %>
							        <%= label_tag Spree.t(:date_from) %>
							        <%= text_field_tag :date_from %>
							        <%= label_tag Spree.t(:date_to) %>
							        <%= text_field_tag :date_to %>
							        <%= submit_tag Spree.t(:show_shippings) %>
							      <% end %>
							      <div class='show_tracking'></div>
							  </fieldset>")
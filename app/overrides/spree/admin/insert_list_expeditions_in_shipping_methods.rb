Deface::Override.new(virtual_path: 'spree/admin/shipping_methods/edit',
					 name: 'insert_list_expeditions_in_shipping_methods',
					 insert_after: 'div[data-hook="admin_shipping_method_edit_form"]',
					 text: "<% if @shipping_method.name =~ /^Seur/ %>
					 		<fieldset>
							    <legend><%= Spree.t(:show_shipping_status) %></legend>
							      <%= link_to  Spree.t(:got_to_show_shipping_status), admin_shipping_method_path(@shipping_method), class: 'button fa fa-truck'%>
							  </fieldset>
							<% end %>")
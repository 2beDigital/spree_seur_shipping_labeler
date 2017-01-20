Deface::Override.new(virtual_path: 'spree/orders/show',
					 name: 'insert_show_tracking',
					 insert_before: 'p[data-hook="links"]',
					 text: '<h3 id="tracking_status"><%= Spree.t(:show_tracking_status) %></h3>
					 		<div id="tracking">
					 		<% if @delivery_status && @delivery_status[:error].blank? %>						 		
						 		<%= render partial: ("spree/shared/show_tracking") %>
						 	<% else %>
								<h6><%= Spree.t(:delivery_in_progress) %></h6>
						 	<% end %>
						 	</div>')
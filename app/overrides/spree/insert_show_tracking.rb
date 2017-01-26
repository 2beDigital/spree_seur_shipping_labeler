Deface::Override.new(virtual_path: 'spree/orders/show',
					 name: 'insert_show_tracking',
					 insert_before: 'p[data-hook="links"]',
					 text: '<% if !@delivery.blank? %>
						 		<h3 id="tracking_status"><%= Spree.t(:show_tracking_status) %></h3>
						 		<div id="tracking">					 								 		
						 			<%= render partial: ("spree/shared/show_tracking") %>
						 		</div>
						 	<% end %>')
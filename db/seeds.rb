dimensions = [
  ['Modelo A', '35x29x36'],
  ['Modelo B', '37x22.5x11'],
  ['Modelo C', '28x20x23'],
  ['Modelo D', '23.5x20x9'],
  ['Modelo E', '60x45x45']]

dimensions.each do |desc, lwh|
  l,w,h = lwh.split('x')

  box = Spree::Shipping::Box.where(
    description: desc,
    length:      l,
    width:       w,
    height:      h).first_or_create!

  puts "Ensured existence of shipping box #{box.description}"
end
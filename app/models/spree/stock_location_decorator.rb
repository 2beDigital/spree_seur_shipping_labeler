Spree::StockLocation.class_eval do
  def seur_formatted
    {
      company:       Spree.t(:company_name),
      phone_number:  phone,
      address:       [address1, address2].compact.join(' '),
      city:          city,
      state:         state,
      zip_code:      zipcode,
      country:       country.name,
      country_iso:   country.iso
    }
  end                                       
end

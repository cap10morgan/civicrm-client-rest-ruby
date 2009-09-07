require 'lib/civicrm'

civicrm_url = 'http://localhost/civicrm22'
civicrm_sitekey = '6f07f540259e9f5c55cae6b86c40c06f'

civicrm = CiviCRM::RESTClient.new(civicrm_url, civicrm_sitekey)

params = { 'name' => 'http://cap10morgan.myopenid.com/',
  'pass' => '987654321' }
civicrm.login(params)

# lookup a contact
params = { 'email' => 'cap10morgan@gmail.com' }
response = civicrm.contact_search(params)
print "Contact search response: \n"
p response

response.each_key do |contact_id|
  contact = response[contact_id]
  print "Found contact: #{contact['display_name']}\n"
end

# create a contact
contact = {
  'first_name' => 'Wes',
  'last_name' => 'Morgan',
  'contact_type' => 'Individual',
}

location = {
  'email' => 'wesmorgan@iphonefloss.com',
  'phone' => '303-832-1185',
  'street_address' => '1311 Marion St.',
  'city' => 'Denver',
  'state_province' => 'CO',
  'postal_code' => '80218',
  'postal_code_suffix' => '2208',
  'country' => 'United States',
  'location_type' => 'Main',
  'is_primary' => 1,
}

response = civicrm.contact_add(contact)
print "Added contact: "
p response
contact_id = response['contact_id']
location['contact_id'] = contact_id
response = civicrm.location_add(location)
print "Added location: "
p response
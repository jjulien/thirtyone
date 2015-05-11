# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
types = ['Prayer Request', 'Comment', 'Needs', 'Follow Up']
types.each do |type|
  NoteType.find_or_create_by(name: type)
end

states = [{ :name => 'Alabama', :abbreviation => 'AL' },
          { :name => 'Alaska', :abbreviation => 'AK' },
          { :name => 'Arizona', :abbreviation => 'AZ' },
          { :name => 'Arkansas', :abbreviation => 'AR' },
          { :name => 'California', :abbreviation => 'CA' },
          { :name => 'Colorado', :abbreviation => 'CO' },
          { :name => 'Connecticut', :abbreviation => 'CT' },
          { :name => 'Delaware', :abbreviation => 'DE' },
          { :name => 'District of Columbia', :abbreviation => 'DC' },
          { :name => 'Florida', :abbreviation => 'FL' },
          { :name => 'Georgia', :abbreviation => 'GA' },
          { :name => 'Hawaii', :abbreviation => 'HI' },
          { :name => 'Idaho', :abbreviation => 'ID' },
          { :name => 'Illinois', :abbreviation => 'IL' },
          { :name => 'Indiana', :abbreviation => 'IN' },
          { :name => 'Iowa', :abbreviation => 'IA' },
          { :name => 'Kansas', :abbreviation => 'KS' },
          { :name => 'Kentucky', :abbreviation => 'KY' },
          { :name => 'Louisiana', :abbreviation => 'LA' },
          { :name => 'Maine', :abbreviation => 'ME' },
          { :name => 'Maryland', :abbreviation => 'MD' },
          { :name => 'Massachusetts', :abbreviation => 'MA' },
          { :name => 'Michigan', :abbreviation => 'MI' },
          { :name => 'Minnesota', :abbreviation => 'MN' },
          { :name => 'Mississippi', :abbreviation => 'MS' },
          { :name => 'Missouri', :abbreviation => 'MO' },
          { :name => 'Montana', :abbreviation => 'MT' },
          { :name => 'Nebraska', :abbreviation => 'NE' },
          { :name => 'Nevada', :abbreviation => 'NV' },
          { :name => 'New Hampshire', :abbreviation => 'NH' },
          { :name => 'New Jersey', :abbreviation => 'NJ' },
          { :name => 'New Mexico', :abbreviation => 'NM' },
          { :name => 'New York', :abbreviation => 'NY' },
          { :name => 'North Carolina', :abbreviation => 'NC' },
          { :name => 'North Dakota', :abbreviation => 'ND' },
          { :name => 'Ohio', :abbreviation => 'OH' },
          { :name => 'Oklahoma', :abbreviation => 'OK' },
          { :name => 'Oregon', :abbreviation => 'OR' },
          { :name => 'Pennsylvania', :abbreviation => 'PA' },
          { :name => 'Rhode Island', :abbreviation => 'RI' },
          { :name => 'South Carolina', :abbreviation => 'SC' },
          { :name => 'South Dakota', :abbreviation => 'SD' },
          { :name => 'Tennessee', :abbreviation => 'TN' },
          { :name => 'Texas', :abbreviation => 'TX' },
          { :name => 'Utah', :abbreviation => 'UT' },
          { :name => 'Vermont', :abbreviation => 'VT' },
          { :name => 'Virginia', :abbreviation => 'VA' },
          { :name => 'Washington', :abbreviation => 'WA' },
          { :name => 'West Virginia', :abbreviation => 'WV' },
          { :name => 'Wisconsin', :abbreviation => 'WI' },
          { :name => 'Wyoming', :abbreviation => 'WY' }]

states.each do |s|
 State.find_or_create_by(s)
end

roles = [{ :name => 'Admin', :permissions => PERM_ADMIN },
         { :name => 'Add All', :permissions => PERM_RW_PERSON | PERM_RW_SCHEDULE | PERM_RW_USER | PERM_RW_RESOURCE | PERM_RW_VISIT | PERM_RW_PRAYER_REQUEST },
         { :name => 'View All', :permissions => PERM_RO_PERSON | PERM_RO_SCHEDULE | PERM_RO_USER | PERM_RO_RESOURCE | PERM_RO_VISIT | PERM_RO_PRAYER_REQUEST },
         { :name => 'Prayer Warrior', :permissions => PERM_RO_PRAYER_REQUEST | PERM_RW_PRAYER_REQUEST },
         { :name => 'Organizer', :permissions => PERM_RO_SCHEDULE | PERM_RW_SCHEDULE | PERM_RO_VISIT | PERM_RW_VISIT },
         { :name => 'Manager', :permissions => PERM_RO_PERSON | PERM_RW_PERSON | PERM_RO_USER | PERM_RW_USER | PERM_RO_RESOURCE | PERM_RW_RESOURCE },
         { :name => 'User', :permissions => PERM_RO_SCHEDULE | PERM_RW_SCHEDULE | PERM_RO_RESOURCE | PERM_RW_RESOURCE | PERM_RO_VISIT | PERM_RW_VISIT | PERM_RW_PRAYER_REQUEST }]

roles.each do |r|
  Role.find_or_create_by(r)
end

# This may look weird, but it neccessary to jump around all the devise validation code.  Without it the user would not save as the email is invalid and the password is too short
user = User.find_or_initialize_by({email: 'admin'})
user.password = 'admin'
admin_role = Role.find_by({name: 'Admin'})
user.roles << admin_role if not user.roles.include?(admin_role)
if not user.person
  user.person = Person.new({firstname: "Pantry", lastname: "Administrator", email: 'admin'})
end
user.save!({validate: false})

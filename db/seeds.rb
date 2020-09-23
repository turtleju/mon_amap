# frozen_string_literal: true

User.destroy_all
Amap.destroy_all

admin = User.new(
  email: 'admin@example.com',
  password: 'azerty',
  first_name: 'admin',
  last_name: 'Admin',
  admin: true
)
admin.skip_confirmation!
admin.save!

user1 = User.new(
  email: 'user1@example.com',
  password: 'azerty',
  first_name: 'user1',
  last_name: 'USER1'
)
user1.skip_confirmation!
user1.save!

amap_curis = Amap.create!(
  name: 'Amap de Curis',
  subdomain: 'curis',
  legal_address: "1032 Route des Monts-d'Or, 69250 Curis-au-Mont-d'Or",
  distribution_address: "1032 Route des Monts-d'Or, 69250 Curis-au-Mont-d'Or",
  latitude: 45.870564,
  longitude: 4.820168,
  description: 'Nous nous retrouvons tous les mercredi à partir de 17h, pour une distribution dans la joie et la bonne humeur',
  manager: user1
)

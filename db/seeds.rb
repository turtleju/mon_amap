# frozen_string_literal: true

Subscription.destroy_all
DeliveryDay.destroy_all
Formula.destroy_all
PeriodDay.destroy_all
Period.destroy_all
AmapProducer.destroy_all
Producer.destroy_all
Amap.destroy_all
User.destroy_all

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

user2 = User.new(
  email: 'visitor1@example.com',
  password: 'azerty',
  first_name: 'visitor1',
  last_name: 'VISITOR1'
)
user2.skip_confirmation!
user2.save!

amap1 = Amap.create!(
  name: 'Amap de Curis',
  subdomain: 'curis',
  legal_address: "1032 Route des Monts-d'Or, 69250 Curis-au-Mont-d'Or",
  distribution_address: "1032 Route des Monts-d'Or, 69250 Curis-au-Mont-d'Or",
  latitude: 45.870564,
  longitude: 4.820168,
  description: 'Nous nous retrouvons tous les mercredi à partir de 17h, pour une distribution dans la joie et la bonne humeur',
  manager: user1,
  distribution_day: 'tuesday'
)

amap2 = Amap.create!(
  name: 'Amap de Neuville',
  subdomain: 'neuville',
  legal_address: 'place principale',
  distribution_address: 'place principale',
  latitude: 45.890564,
  longitude: 4.820168,
  description: 'Nous nous retrouvons tous les mercredi à partir de 17h, pour une distribution dans la joie et la bonne humeur',
  manager: user1,
  distribution_day: 'wednesday'
)

producer1 = Producer.new(
  email: 'producer1@example.com',
  password: 'azerty',
  first_name: 'producer1',
  last_name: 'producer1'
)
producer1.skip_confirmation!
producer1.save!

producer1.amaps << amap1

producer2 = Producer.new(
  email: 'producer2@example.com',
  password: 'azerty',
  first_name: 'producer2',
  last_name: 'producer2'
)
producer2.skip_confirmation!
producer2.save!

producer2.amaps << amap1

period11_attributes = {
  start_on: 20.days.from_now - 1.year + 1.day,
  finish_on: 20.days.from_now,
  price: 15
}

period12_attributes = {
  start_on: 21.days.from_now,
  finish_on: 21.days.from_now + 1.year - 1.day,
  price: 18
}

period11 = CreatePeriod.call(period11_attributes, amap1)
period12 = CreatePeriod.call(period12_attributes, amap1)

formule111_attributes = {
  category: 'bread',
  name: 'Les baguettes familiales',
  description: '5 baguettes mais qui durent toute la semaine',
  price: '10.00',
  period: period11,
  producer: producer1

}

formule112_attributes = {
  category: 'bread',
  name: '3 pains complets',
  description: '3 gros pains pour gros mangeur',
  price: '20.00',
  period: period11,
  producer: producer1

}

formule111 = Formula.create!(formule111_attributes)
formule112 = Formula.create!(formule112_attributes)

[formule111, formule112].each do |formula|
  formula.period.period_days.first(20).each do |period_day|
    DeliveryDay.create!(period_day: period_day, formula: formula)
  end
end

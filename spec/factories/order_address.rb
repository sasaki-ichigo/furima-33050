FactoryBot.define do
  Faker::Config.locale = :ja
  factory :order_address do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code { Faker::Address.postcode }
    prefecture_id { Faker::Number.within(range: 2..48) }
    municipality { 'あア' + Faker::Address.city }
    address { 'あア' + Faker::Address.city + Faker::Address.zip_code }
    building_name { 'あア' + Faker::Address.city + Faker::Address.zip_code }
    phone_number { Faker::Number.number(digits: 11) }
  end
end
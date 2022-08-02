FactoryBot.define do
  factory :order_form do
    postal_code { '000-0000' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { '佐野市' }
    block{ '1-2-3' }
    building { 'ハイツ307号' }
    phone_number { '00011112222' }
    token { "tok_abcdefghijk00000000000000000" }
  end
end

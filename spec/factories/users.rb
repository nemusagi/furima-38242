FactoryBot.define do
  factory :user do
    Faker::Config.locale = 'ja'
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {'1a' + Faker::Internet.password(min_length: 4)}
    password_confirmation {password}
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    last_name_kana {'テスト'}
    first_name_kana {'テスト'}
    birthday {Faker::Date.birthday}
  end
end
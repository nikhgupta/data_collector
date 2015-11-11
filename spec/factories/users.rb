FactoryGirl.define do
  factory :user do
    name nil
    uuid { SecureRandom.uuid.upcase }
    admin false
    fake false
    sequence(:email){|n| "user#{n}@example.com" }
    password "password"
    password_confirmation { password }

    initialize_with do
      User.find_or_initialize_by(email: email)
    end

    factory :admin do
      admin true
    end

    factory :fake_user do
      fake true
      email { "#{uuid}@example.com" }
      password { Devise.friendly_token[0..20] }
    end
  end
end

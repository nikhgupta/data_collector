FactoryGirl.define do
  factory :sensor do
    user
    uuid { SecureRandom.uuid.upcase }
    format "integer"
    length 12
  end
end

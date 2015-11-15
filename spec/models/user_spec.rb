require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid string representation" do
    user = build_stubbed :user, name: "abcd"
    expect(user.name).to eq "abcd"
    user = build_stubbed :user, email: "someone@example.com", name: nil
    expect(user.name).to eq "someone@example.com"
  end

  it "upcases UUID before saving them in databae" do
    user = create :user, uuid: "abcd"
    expect(user.uuid).to eq "ABCD"
    user.update_attribute :uuid, "efgh"
    expect(user.uuid).to eq "EFGH"
  end

  it "can find a user by his UUID" do
    user = create :user, uuid: "ABCD"
    expect(User.find_by_uuid("abcd")).to eq user
  end
end

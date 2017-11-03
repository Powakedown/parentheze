require "rails_helper"

RSpec.describe Guest, :type => :model do
  it "can't be created without email" do
    test_guest = Guest.create

    expect(Guest.last).not_to eq(test_guest)
  end

  it "can't be created with wrong format email" do
    test_guest = Guest.create(email: "test@test")

    expect(Guest.last).not_to eq(test_guest)
  end

  it "can't be created with blank email" do
    test_guest = Guest.create(email: "")

    expect(Guest.last).not_to eq(test_guest)
  end
end

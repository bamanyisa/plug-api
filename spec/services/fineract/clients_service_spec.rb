require "rails_helper"

RSpec.describe Fineract::ClientsService do
  it "creates a client" do
    org = create(:organization)
    borrower = create(:borrower, organization: org)

    stub_request(:post, "https://fineract.example.com/fineract-provider/api/v1/clients")
      .to_return(status: 200, body: { resourceId: 1234 }.to_json, headers: { "Content-Type" => "application/json" })

    response = described_class.new(org).create(borrower)
    expect(response["resourceId"]).to eq(1234)
  end
end

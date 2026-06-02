class SyncBorrowerToFineractJob < ApplicationJob
  def perform(organization_id, record_id)
    with_tenant(organization_id) do |org|
      borrower = Borrower.find(record_id)
      response = Fineract::ClientsService.new(org, system_token).create(borrower)
      borrower.update!(fineract_client_id: response["clientId"] || response["resourceId"], sync_status: "synced", synced_at: Time.current)
    end
  end
end

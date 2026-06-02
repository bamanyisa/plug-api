class SyncLoanProductToFineractJob < ApplicationJob
  def perform(organization_id, record_id)
    with_tenant(organization_id) do |org|
      loan_product = LoanProduct.find(record_id)
      response = Fineract::LoanProductsService.new(org, system_token).create(loan_product)
      loan_product.update!(fineract_product_id: response["resourceId"], sync_status: "synced", synced_at: Time.current)
    end
  end
end

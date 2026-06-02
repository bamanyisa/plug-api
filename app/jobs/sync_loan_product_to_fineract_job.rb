class SyncLoanProductToFineractJob < ApplicationJob
  def perform(organization_id, record_id)
    with_tenant(organization_id) do
      loan_product = LoanProduct.find(record_id)
      response = Fineract::LoanProductsService.new(loan_product.organization).create(loan_product)
      loan_product.update!(fineract_product_id: response["resourceId"], sync_status: "synced", synced_at: Time.current)
    end
  end
end

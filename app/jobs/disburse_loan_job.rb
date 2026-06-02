class DisburseLoanJob < ApplicationJob
  def perform(organization_id, disbursement_id)
    with_tenant(organization_id) do |org|
      disbursement = Disbursement.find(disbursement_id)
      response = Fineract::LoansService.new(org, system_token).disburse(
        disbursement.loan.fineract_loan_id,
        disbursement.amount,
        disbursement.disbursed_on,
        nil
      )
      disbursement.update!(fineract_transaction_id: response["resourceId"] || response["subResourceId"])
    end
  end
end

class SyncLoanProductToFineractJob < ApplicationJob
  def perform(organization_id, record_id)
    with_tenant(organization_id) do
      # TODO: implement
    end
  end
end

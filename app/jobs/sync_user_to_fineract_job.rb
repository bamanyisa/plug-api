class SyncUserToFineractJob < ApplicationJob
  def perform(organization_id, record_id)
    with_tenant(organization_id) do
      user = User.find(record_id)
      service = Fineract::StaffService.new(user.organization)
      staff_id = service.create_staff(user)
      user.update!(fineract_staff_id: staff_id, fineract_username: user.fineract_username || user.email)
      appuser_id = service.create_appuser(user, staff_id)
      user.update!(fineract_appuser_id: appuser_id)
    end
  end
end

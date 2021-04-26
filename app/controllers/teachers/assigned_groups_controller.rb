class Teachers::AssignedGroupsController < TeachersController
  before_action :load_assigned_group, only: :publish_score

  def publish_score
    @assigned_group.update published_at: Time.zone.now

    render 
  end

  private

  def load_assigned_group
    @assigned_group = AssignedGroup.find(params[:id])
  end
end

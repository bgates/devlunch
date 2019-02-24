class ChangeInvitationWhoToSlackUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :invitations, :who, :slack_user_id
  end
end

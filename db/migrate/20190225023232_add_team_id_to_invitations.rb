class AddTeamIdToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :team_id, :string
  end
end

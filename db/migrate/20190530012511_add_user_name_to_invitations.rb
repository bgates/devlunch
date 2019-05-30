class AddUserNameToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :user_name, :string
  end
end

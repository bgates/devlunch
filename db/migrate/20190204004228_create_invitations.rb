class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.datetime :when
      t.string :where
      t.string :who

      t.timestamps
    end
  end
end

class AddImageAndCoordinatesAndAddressToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :latitude, :float
    add_column :invitations, :longitude, :float
    add_column :invitations, :address, :string
    add_column :invitations, :image_url, :string
  end
end

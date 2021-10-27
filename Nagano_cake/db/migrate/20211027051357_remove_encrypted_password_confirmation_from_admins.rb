class RemoveEncryptedPasswordConfirmationFromAdmins < ActiveRecord::Migration[5.2]
  def change
    remove_column :admins, :encrypted_password_confirmation, :string
  end
end

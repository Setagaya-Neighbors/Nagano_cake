class RemoveEncryptedPasswordConfirmationFromCustomer < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :encrypted_password_confirmation, :string
  end
end

class AddColumnSlatWithResetPasswordToManageAccounts < ActiveRecord::Migration
  def change
		add_column :manage_accounts, :salt, :string
		add_column :manage_accounts, :crypted_password, :string
    add_column :manage_accounts, :remember_me_token, :string, :default => nil
    add_column :manage_accounts, :remember_me_token_expires_at, :datetime, :default => nil
    add_index :manage_accounts, :remember_me_token
    add_column :manage_accounts, :reset_password_token, :string, :default => nil
    add_column :manage_accounts, :reset_password_token_expires_at, :datetime, :default => nil
    add_column :manage_accounts, :reset_password_email_sent_at, :datetime, :default => nil
    add_index :manage_accounts, :reset_password_token
  end
end

class DeleteApiAuthorizations < ActiveRecord::Migration[6.0]
  def change
    drop_table :api_authorizations
  end
end

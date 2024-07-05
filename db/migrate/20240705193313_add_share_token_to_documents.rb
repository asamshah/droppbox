class AddShareTokenToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :share_token, :string
    add_index :documents, :share_token, unique: true
  end
end

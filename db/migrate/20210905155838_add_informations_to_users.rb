class AddInformationsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :text
    add_column :users, :lastname, :text
  end
end

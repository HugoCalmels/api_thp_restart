class UpdateForeignKeyArticles < ActiveRecord::Migration[6.1]
  def change
    # remove the old foreign_key
    remove_foreign_key :articles, :users

    # add the new foreign_key
    add_foreign_key :articles, :users, on_delete: :cascade
  end
end

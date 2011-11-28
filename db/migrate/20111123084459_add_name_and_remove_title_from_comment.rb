class AddNameAndRemoveTitleFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :title
    add_column :comments, :name, :string
    add_column :comments, :email, :string
  end
end

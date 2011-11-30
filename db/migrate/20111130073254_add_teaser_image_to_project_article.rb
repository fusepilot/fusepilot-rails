class AddTeaserImageToProjectArticle < ActiveRecord::Migration
  def change
    add_column :articles, :teaser_file_name,    :string
    add_column :articles, :teaser_content_type, :string
    add_column :articles, :teaser_file_size,    :integer
    add_column :articles, :teaser_updated_at,   :datetime

    add_column :projects, :teaser_file_name,    :string
    add_column :projects, :teaser_content_type, :string
    add_column :projects, :teaser_file_size,    :integer
    add_column :projects, :teaser_updated_at,   :datetime
  end
end

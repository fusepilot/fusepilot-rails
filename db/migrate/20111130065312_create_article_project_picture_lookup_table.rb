class CreateArticleProjectPictureLookupTable < ActiveRecord::Migration
  def change
    create_table :articles_pictures do |t|
      t.integer :article_id
      t.integer :picture_id
    end

    create_table :pictures_projects do |t|
      t.integer :project_id
      t.integer :picture_id
    end
  end
end

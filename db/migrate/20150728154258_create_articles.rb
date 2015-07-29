class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :source
      t.references :category, index: true

      t.timestamps null: false
    end
  end
end

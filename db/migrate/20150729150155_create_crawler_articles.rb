class CreateCrawlerArticles < ActiveRecord::Migration
  def change
    create_table :crawler_articles do |t|
      t.string  :title
      t.string  :url
      t.string  :type
      t.references :article, index: true

      t.timestamps null: false
    end
  end
end

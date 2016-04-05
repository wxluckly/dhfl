class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
    	t.string		:name
    	t.text			:content
    	t.integer 	:position, default: 128
    	t.boolean 	:is_valid, default: true

      t.timestamps null: false
    end
  end
end

class CreatePostsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

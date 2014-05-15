class CreateRemotePosts < ActiveRecord::Migration
  def change
    create_table :remote_posts do |t|
      t.references :comment

      t.string :source
      t.string :title
      t.string :h1
      t.string :logo_url

      t.timestamps
    end

    add_index :remote_posts, :comment_id
  end
end

class CreateCommentImages < ActiveRecord::Migration
  def change
    create_table :comment_images do |t|
      t.references :comment
      t.string :image

      t.timestamps
    end

    add_index :comment_images, :comment_id
  end
end

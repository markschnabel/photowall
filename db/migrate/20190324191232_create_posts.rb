class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image
      t.string :posted_by, :default => "anonymous"
      t.text :caption

      t.timestamps
    end
  end
end

class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.integer :user_id
  		t.text :posts
  		belongs_to :users
  	end
  end
end

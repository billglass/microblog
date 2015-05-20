class User < ActiveRecord::Base
	has_many :posts
	has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy #(if user is deleted, all relationships destroyed)
	has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy 

	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

# def follow
# 	@following.create(follower_id: followed_id)
# 	insert into relationship table

# end

# def unfollow
# 	@following.find_by(follower_id: followed_id).destroy
# 	destroy!

end

class Post < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true, length: {maximum: 150}
end

class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
	#maps to User table
	validates_uniqueness_of :follower_id, scope: :followed_id

end

	#there should be no repeated pairs inside of this table

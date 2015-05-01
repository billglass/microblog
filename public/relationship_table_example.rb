class RelationshipsTable
	def chang
		create_table :relationships do |t|
			t.integer :follower_id
			t.integer :followed_id
		end
	end
end
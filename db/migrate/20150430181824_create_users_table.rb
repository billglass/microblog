class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :email
  		t.string :password
  		t.string :fname
  		t.string :lname
  		t.integer :phone
  		t.string :city
  		t.integer :birthday
  		t.string :gender
  		t.string :superhero
  		t.string :website
  	end
  end
end

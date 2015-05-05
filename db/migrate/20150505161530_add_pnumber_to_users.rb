class AddPnumberToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :pnumber, :string
  end
end

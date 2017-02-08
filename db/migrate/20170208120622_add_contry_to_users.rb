class AddContryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
  end
end

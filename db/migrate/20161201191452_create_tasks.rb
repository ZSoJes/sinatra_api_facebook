class CreateTasks < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :oauth_token 
      t.string :oauth_expires_at
    end
  end
end

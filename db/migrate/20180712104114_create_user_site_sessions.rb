class CreateUserSiteSessions < ActiveRecord::Migration
  def change
    create_table :user_site_sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

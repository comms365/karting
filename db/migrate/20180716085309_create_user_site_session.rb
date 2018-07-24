class CreateUserSiteSessions < ActiveRecord::Migration
  def change
    create_table :user_site_sessions do |t|
      t.decimal :lap_time
      t.integer :weather
      t.date :session_date
      t.timestamps
    end
  end
end

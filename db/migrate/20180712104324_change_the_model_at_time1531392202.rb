class ChangeTheModelAtTime1531392202 < ActiveRecord::Migration
  def change
    add_column :user_site_sessions, :weather, :integer, null: false
    add_column :user_site_sessions, :lap_time, :float, null: false
    add_column :user_site_sessions, :session_date, :datetime, null: false
  end
end

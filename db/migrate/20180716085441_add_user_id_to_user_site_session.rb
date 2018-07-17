class AddUserIdToUserSiteSession < ActiveRecord::Migration
  def change
  	add_column :user_site_sessions, :session_date, :date
  	add_column :user_site_sessions, :weather, :integer
  	add_column :user_site_sessions, :lap_time, :decimal
  	add_reference :user_site_sessions, :user, index:true
  	add_reference :user_site_sessions, :site, index:true
  end
end

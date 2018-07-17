class DropUserSiteSessionTable < ActiveRecord::Migration
  def change
  	drop_table :user_site_sessions
  end
end

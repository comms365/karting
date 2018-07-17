class Create < ActiveRecord::Migration
  def change
  	add_reference :user_site_sessions, :user, index:true
  	add_reference :user_site_sessions, :site, index:true
  end
end

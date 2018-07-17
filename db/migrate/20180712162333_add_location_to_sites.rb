class AddLocationToSites < ActiveRecord::Migration
  def change
    add_column :sites, :location, :string
  end
end

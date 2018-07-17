class AddDeletedAtToSites < ActiveRecord::Migration
  def change
    add_column :sites, :deleted_at, :datetime
  end
end

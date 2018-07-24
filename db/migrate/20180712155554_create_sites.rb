class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :location
      t.timestamps
      t.datetime :deleted_at
    end
  end
end

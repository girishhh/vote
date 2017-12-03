class AddDistrictIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :district_id, :integer
  end
end

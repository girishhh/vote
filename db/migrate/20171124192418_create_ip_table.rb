class CreateIpTable < ActiveRecord::Migration
  def change
    create_table :ip_tables do |t|
      t.string :address
      t.integer :place_id
    end
  end
end

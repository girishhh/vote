class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.integer :vote_count,default: 0
      t.string :candidate_name
    end
  end
end

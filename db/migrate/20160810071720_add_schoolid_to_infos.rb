class AddSchoolidToInfos < ActiveRecord::Migration
  def change
    add_column :infos, :school_id, :integer
  end
end

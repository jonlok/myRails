class AddAddressToInfos < ActiveRecord::Migration
  def change
    add_column :infos, :address, :string
  end
end

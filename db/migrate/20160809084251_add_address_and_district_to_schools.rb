class AddAddressAndDistrictToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :address, :string
    add_column :schools, :district, :string
  end
end

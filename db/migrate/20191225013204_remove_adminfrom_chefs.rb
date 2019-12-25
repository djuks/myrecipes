class RemoveAdminfromChefs < ActiveRecord::Migration[5.1]
  def change
    remove_column :chefs, :admin
  end
end

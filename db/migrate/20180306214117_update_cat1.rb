class UpdateCat1 < ActiveRecord::Migration[5.1]
  def change
    change_column :cats, :birthday, :date
  end
end

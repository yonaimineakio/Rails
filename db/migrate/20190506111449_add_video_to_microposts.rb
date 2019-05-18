class AddVideoToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :video, :string
  end
end

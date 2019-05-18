class AddVideoToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :video, :string
  end
end

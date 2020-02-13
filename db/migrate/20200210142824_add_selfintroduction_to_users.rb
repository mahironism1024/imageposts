class AddSelfintroductionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :selfintroduction, :string
  end
end

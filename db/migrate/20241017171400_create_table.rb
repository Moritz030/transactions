class CreateTable < ActiveRecord::Migration[7.2]
  def change
    create_table(:example_records, primary_key: :id) do |t|
      t.column :attribute_1, :string
      t.column :attribute_2, :string
    end
  end
end
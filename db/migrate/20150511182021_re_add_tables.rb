class ReAddTables < ActiveRecord::Migration
  def change
    create_table(:tasks) do |t|
      t.column(:description, :string)
      t.column(:done, :boolean)
      t.column(:due_date, :datetime)
      
      t.timestamps()
    end
  end
end

class CreateTestingAlgorithms < ActiveRecord::Migration
  def change
    create_table :testing_algorithms do |t|

      t.timestamps
    end
  end
end

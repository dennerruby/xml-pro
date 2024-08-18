class CreateXmlProcessings < ActiveRecord::Migration[7.0]
  def change
    create_table :xml_processings do |t|

      t.timestamps
    end
  end
end

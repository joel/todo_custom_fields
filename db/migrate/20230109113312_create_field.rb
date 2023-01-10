# frozen_string_literal: true

class CreateField < ActiveRecord::Migration[7.0]
  def change
    create_table :fields do |t|
      t.string :name
      t.string :identifier
      t.json :metadata, default: {}
      t.json :policy, default: {}
      t.integer :position, default: 0

      t.references :source, polymorphic: true, null: true
      t.string :field_type, default: "string"

      t.timestamps
    end
  end
end

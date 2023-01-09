# frozen_string_literal: true

class CreateField < ActiveRecord::Migration[7.0]
  def change
    create_table :fields do |t|
      t.string :name
      t.json :metadata

      t.references :source, polymorphic: true, null: true
      t.references :target, polymorphic: true, null: true

      t.timestamps
    end
  end
end

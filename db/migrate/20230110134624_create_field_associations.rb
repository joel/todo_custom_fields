# frozen_string_literal: true

class CreateFieldAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :field_associations do |t|
      t.references :field, null: false, foreign_key: true
      t.references :target, polymorphic: true, null: false
      t.string :value
      t.integer :position

      t.timestamps
    end
  end
end

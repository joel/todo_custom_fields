# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.string :name
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.belongs_to :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end

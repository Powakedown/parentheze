# frozen_string_literal: true

class AddColumnVisitToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :visit, :integer
  end
end

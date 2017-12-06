# frozen_string_literal: true

class AddGetoutToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :get_out, :integer
  end
end

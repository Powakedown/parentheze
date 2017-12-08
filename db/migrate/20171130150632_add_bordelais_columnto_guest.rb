# frozen_string_literal: true

class AddBordelaisColumntoGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :bordelais, :boolean
  end
end

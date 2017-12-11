# frozen_string_literal: true

class SetDefaulfEmailToGuest < ActiveRecord::Migration[5.1]
  def change
    change_column :guests, :email, :string, default: 'email@example.com'
  end
end

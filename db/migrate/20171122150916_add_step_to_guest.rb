# frozen_string_literal: true

class AddStepToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :step, :integer
  end
end

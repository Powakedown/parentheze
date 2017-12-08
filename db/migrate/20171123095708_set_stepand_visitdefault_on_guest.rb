# frozen_string_literal: true

class SetStepandVisitdefaultOnGuest < ActiveRecord::Migration[5.1]
  def change
    change_column :guests, :step, :integer, default: 0
    change_column :guests, :visit, :integer, default: 0
  end
end

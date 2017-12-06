# frozen_string_literal: true


ActiveRecord::Schema.define(version: 20_171_130_150_632) do
  enable_extension 'plpgsql'

  create_table 'guests', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'parent'
    t.integer 'kid_age'
    t.integer 'jalous'
    t.integer 'old_kid'
    t.string 'name'
    t.string 'email', default: 'email@example.com'
    t.integer 'get_out'
    t.integer 'visit', default: 0
    t.integer 'step', default: 0
    t.boolean 'bordelais'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end

# frozen_string_literal: true

require 'rails_helper'

feature 'User homepage' do
  scenario 'Visit home and subscribe' do
    visit root_path
    expect(page).to have_css 'h1', text: I18n.t('home.slides.slide0.title')
    fill_in 'guest[email]', with: 'test@test.com'
    click_on "S'inscrire"

    expect(page).to have_css 'h1', text: I18n.t('inscription.redirection.title')
  end

  scenario 'Visit home and subscribe with wrong email' do
    visit root_path
    expect(page).to have_css 'h1', text: I18n.t('home.slides.slide0.title')
    fill_in 'guest[email]', with: 'testtest.com'
    click_on "S'inscrire"

    expect(page).to have_css 'div', class: 'alert-warning'
  end
end

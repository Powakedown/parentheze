# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routing', type: :routing do
  it 'display home as root' do
    expect(get: '/home').to route_to(
      controller: 'pages',
      action: 'home'
    )
  end
end

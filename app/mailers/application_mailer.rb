# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'parentgenial@parentheze.com'
  layout 'mailer'
end

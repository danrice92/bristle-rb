class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@bristle.work'
  layout 'mailer'
end

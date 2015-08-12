class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@hivemind-uon.herokuapp.com"
  layout 'mailer'
end

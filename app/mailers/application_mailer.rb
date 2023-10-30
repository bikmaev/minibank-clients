# frozen_string_literal: true

# default mailer
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end

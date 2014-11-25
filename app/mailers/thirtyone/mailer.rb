if defined?(ActionMailer)
  class Thirtyone::Mailer < Devise::Mailer
    include Devise::Mailers::Helpers
    def new_account_instructions(record, token, opts={})
      @token = token
      devise_mail(record, :new_account_instructions, opts)
    end
  end
end
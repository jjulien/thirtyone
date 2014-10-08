if defined?(ActionMailer)
  class Devise::Mailer < Devise.parent_mailer.constantize
    include Devise::Mailers::Helpers
    def new_account_instructions(record, token, opts={})
      @token = token
      devise_mail(record, :new_account_instructions, opts)
    end
  end
end

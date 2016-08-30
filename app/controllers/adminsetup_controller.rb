class AdminsetupController < ApplicationController

  def setup
    @user = current_user
  end

end

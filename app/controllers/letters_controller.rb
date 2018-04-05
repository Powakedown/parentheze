module Admin
  class LettersController < ApplicationController
    before_action :security_check

    def index
      @letters = Letter.preload(:user).order(:state)
    end
  end
end

module Admin
  class LettersController < ApplicationController
    before_action :security_check

    def index
      @letters = Letter.preload(:user).order(:state)
    end

    def update
      @letter = Letter.find(params[:id])
      @letter.state = 1
      if @letter.save!
        flash[:notice] = t('.notice')
        redirect_to controller: "letters", action: "index"
      else
        flash[:warning] = t('.warning')
      end
    end
  end
end

module Admin
  class LettersController < ApplicationController
    before_action :security_check
    before_action :params_letter, only: %i(update destroy export)

    def destroy
      @letter.destroy
      redirect_to controller: "letters", action: "index"
    end

    def export
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Letter to School"
        end
      end
    end

    def index
      @letters = Letter.preload(:user).order(:state)
    end

    def update
      @letter.state = 1
      if @letter.save!
        flash[:notice] = t('.notice')
        redirect_to controller: "letters", action: "index"
      else
        flash[:warning] = t('.warning')
      end
    end

    private

    def params_letter
      @letter = Letter.find(params[:id])
    end
  end
end

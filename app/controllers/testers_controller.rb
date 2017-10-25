class TestersController < ApplicationController
  def create
    @tester = Tester.new(params_tester)
    @tester.save!
    flash.now[:alert] = t('flash.tester.new')
  end

  private

  def params_tester
    params.require(:tester).permit(:email)
  end
end

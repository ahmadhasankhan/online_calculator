class CalculatorsController < ApplicationController
  def index
  end

  def calculate
    @message = nil
    begin
      @result = Calculator.new.evaluate(params[:q])
    rescue => e
      @message = e
      @result = nil
    end

    respond_to do |format|
      if @result
        format.js {render :calculate}
        format.json {render json: @result, status: :ok}
      else
        format.js {render :calculate}
        format.json {render json: @result, status: :unprocessable_entity}
      end
    end
  end
end

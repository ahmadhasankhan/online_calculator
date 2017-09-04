class CalculatorsController < ApplicationController
  def index
  end

  def calculate
    results = Calculator.new.evaluate(params[:q])
    @message = results[:message]
    @result = results[:result]

    respond_to do |format|
      if @result
        format.js {render :calculate, status: :ok}
        format.json {render json: @result, status: :ok}
      else
        format.js {render :calculate, status: :unprocessable_entity}
        format.json {render json: @result, status: :unprocessable_entity}
      end
    end
  end
end

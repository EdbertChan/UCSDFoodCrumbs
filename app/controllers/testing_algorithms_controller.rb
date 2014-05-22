class TestingAlgorithmsController < ApplicationController
  # GET /testing_algorithms
  # GET /testing_algorithms.json
  def index
    @testing_algorithms = TestingAlgorithm.all

    render json: TestingAlgorithm.algorithm(['hi'],2)
  end

  # GET /testing_algorithms/1
  # GET /testing_algorithms/1.json
  def show
    @testing_algorithm = TestingAlgorithm.find(params[:id])

    render json: @testing_algorithm
  end

  # POST /testing_algorithms
  # POST /testing_algorithms.json
  def create
    @testing_algorithm = TestingAlgorithm.new(params[:testing_algorithm])

    if @testing_algorithm.save
      render json: @testing_algorithm, status: :created, location: @testing_algorithm
    else
      render json: @testing_algorithm.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /testing_algorithms/1
  # PATCH/PUT /testing_algorithms/1.json
  def update
    @testing_algorithm = TestingAlgorithm.find(params[:id])

    if @testing_algorithm.update(params[:testing_algorithm])
      head :no_content
    else
      render json: @testing_algorithm.errors, status: :unprocessable_entity
    end
  end

  # DELETE /testing_algorithms/1
  # DELETE /testing_algorithms/1.json
  def destroy
    @testing_algorithm = TestingAlgorithm.find(params[:id])
    @testing_algorithm.destroy

    head :no_content
  end
end

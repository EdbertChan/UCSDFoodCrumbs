class TestingAlgorithmsController < ApplicationController
  # GET /testing_algorithms
  # GET /testing_algorithms.json
  def index
    @testing_algorithms = TestingAlgorithm.all
    
    outputString = ""
    
    #testing resizeBoxesToCircles
    maxRouteBoxer = [[[31.967974894081266, -118.31697598752635], [33.76661810591874, -116.7109102562369]],[[32.41763569704064, -116.7109102562369], [33.76661810591874, -116.17555501247381]]]
    searchString = "chinese"
    expectedOutput = [[32.75488129926016,-116.44323263435535,41.74598372884352,"chinese"],[33.42937250369921,-116.44323263435535,41.631551811210684,"chinese"],[32.19280529556095,-116.91166847264807,30.248293625750495,"chinese"],[32.19280529556095,-117.31318490547045,30.248293625750495,"chinese"],[32.642466098520316,-116.91166847264807,30.189725632982825,"chinese"],[32.642466098520316,-117.31318490547045,30.189725632982825,"chinese"],[32.19280529556095,-117.7147013382928,30.248293625750495,"chinese"],[32.19280529556095,-118.11621777111517,30.248293625750495,"chinese"],[32.642466098520316,-117.7147013382928,30.189725632982825,"chinese"],[32.642466098520316,-118.11621777111517,30.189725632982825,"chinese"],[33.09212690147969,-116.91166847264807,30.130617896076952,"chinese"],[33.09212690147969,-117.31318490547045,30.130617896076952,"chinese"],[33.54178770443905,-116.91166847264807,30.070981837496884,"chinese"],[33.54178770443905,-117.31318490547045,30.070981837496884,"chinese"],[33.09212690147969,-117.7147013382928,30.130617896076952,"chinese"],[33.09212690147969,-118.11621777111517,30.130617896076952,"chinese"],[33.54178770443905,-117.7147013382928,30.070981837496884,"chinese"],[33.54178770443905,-118.11621777111517,30.070981837496884,"chinese"]]
    testOutput = TestingAlgorithm.resizeBoxesToCircles(maxRouteBoxer,searchString)
    outputString += "Testing resizeBoxesToCircles: " + (testOutput.sort == expectedOutput.sort ? "true" : "false") + "\n"
    
    #testing placesQuery
    
    #testing filterResults
	userRouteBoxer = [[[32.84571278145795, -117.27196255170071], [32.860101927152655, -117.23769981609985]],[[32.860101927152655, -117.27196255170071], [32.8672965, -117.22913413219965]],[[32.8672965, -117.26339686780045],[32.881685645694695, -117.22056844829945]],[[32.881685645694695, -117.25483118390031], [32.88888021854205, -117.22056844829945]]]
    render json: outputString
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

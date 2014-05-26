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
	placesList = {"html_attributions"=>["Listingsby\u003cahref=\"http=>//www.yellowpages.com.au/\"\u003eYellowPages\u003c/a\u003e"],"results"=>[{"formatted_address"=>"529KentStreet,SydneyNSW,Australia","geometry"=>{"location"=>{"lat"=>-33.8750460,"lng"=>151.2052720}},"icon"=>"http=>//maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png","id"=>"827f1ac561d72ec25897df088199315f7cbbc8ed","name"=>"Tetsuya's","rating"=>4.30,"reference"=>"CnRmAAAAmmm3dlSVT3E7rIvwQ0lHBA4sayvxWEc4nZaXSSjRtfKRGoYnfr3d5AvQGk4e0u3oOErXsIJwtd3Wck1Onyw6pCzr8swW4E7dZ6wP4dV6AsXPvodwdVyqHgyGE_K8DqSp5McW_nFcci_-1jXb5Phv-RIQTzv5BjIGS0ufgTslfC6dqBoU7tw8NKUDHg28bPJlL0vGVWVgbTg","types"=>["restaurant","food","establishment"]},{"formatted_address"=>"UpperLevel,OverseasPassengerTerminal/5HicksonRoad,TheRocksNSW,Australia","geometry"=>{"location"=>{"lat"=>-33.8583790,"lng"=>151.2100270}},"icon"=>"http=>//maps.gstatic.com/mapfiles/place_api/icons/cafe-71.png","id"=>"f181b872b9bc680c8966df3e5770ae9839115440","name"=>"Quay","rating"=>4.10,"reference"=>"CnRiAAAADmPDOkn3znv_fX78Ma6X5_t7caEGNdSWnpwMIdDNZkLpVKPnQJXP1ghlySO-ixqs28UtDmJaOlCHn18pxpj7UQjRzR4Kmye6Gijoqoox9bpkaCAJatbJGZEIIUwRbTNIE_L2jGo5BDqiosqU2F5QdBIQbXKrvfQuo6rmu8285j7bDBoUrGrN4r6XQ-PVm260PFt5kwc3EfY","types"=>["cafe","bar","restaurant","food","establishment"]},{"formatted_address"=>"107GeorgeStreet,TheRocksNSW,Australia","geometry"=>{"location"=>{"lat"=>-33.8597750,"lng"=>151.2085920}},"icon"=>"http=>//maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png","id"=>"7beacea28938ae42bcac04faf79a607bf84409e6","name"=>"Rockpool","rating"=>4.0,"reference"=>"CnRlAAAAVK4Ek78r9yHV56I-zbaTxo9YiroCbTlel-ZRj2i6yGAkLwNMm_flMhCl3j8ZHN-jJyG1TvKqBBnKQS2z4Tceu-1kZupZ1HSo5JWRBKd7qt2vKgT8VauiEBQL-zJiKVzSy5rFfilKDLSiLusmdi88ThIQqqj6hKHn5awdj6C4f59ifRoUg67KlbpuGuuW7S1tAH_EyBl6KE4","types"=>["restaurant","food","establishment"]},{"formatted_address"=>"483GeorgeStreet,SydneyNSW,Australia","events"=>[{"event_id"=>"7lH_gK1GphU","summary"=>"GoogleMapsDeveloperMeetup=>Rockin'outwiththePlacesAPI","url"=>"https=>//developers.google.com/places"}],"geometry"=>{"location"=>{"lat"=>-33.8731950,"lng"=>151.2063380}},"icon"=>"http=>//maps.gstatic.com/mapfiles/place_api/icons/civic_building-71.png","id"=>"017049cb4e82412aaf0efbde890e82b7f2987c16","name"=>"ChinatownSydney","rating"=>4.0,"reference"=>"CnRuAAAAsLNeRQtKD7TEUXWG6gYD7ByOVKjQE61GSyeGZrX-pOPVps2BaLBlH0zBHlrVU9DKhsuXra075loWmZUCbczKDPdCaP9FVJXB2NsZ1q7188pqRFik58S9Z1lcWjyVoVqvdUUt9bDMLqxVT4ENmolbgBIQ9Wy0sgDy0BgWyg5kfPMHCxoUOvmhfKC-lTefXGgnsRqEQwn8M0I","types"=>["city_hall","park","restaurant","doctor","train_station","local_government_office","food","health","establishment"]}],"status"=>"OK"}
	
	expectedOutput = {"html_attributions"=>["Listingsby\u003cahref=\"http=>//www.yellowpages.com.au/\"\u003eYellowPages\u003c/a\u003e"],"results"=>[{"formatted_address"=>"529KentStreet,SydneyNSW,Australia","geometry"=>{"location"=>{"lat"=>-33.8750460,"lng"=>151.2052720}},"icon"=>"http=>//maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png","id"=>"827f1ac561d72ec25897df088199315f7cbbc8ed","name"=>"Tetsuya's","rating"=>4.30,"reference"=>"CnRmAAAAmmm3dlSVT3E7rIvwQ0lHBA4sayvxWEc4nZaXSSjRtfKRGoYnfr3d5AvQGk4e0u3oOErXsIJwtd3Wck1Onyw6pCzr8swW4E7dZ6wP4dV6AsXPvodwdVyqHgyGE_K8DqSp5McW_nFcci_-1jXb5Phv-RIQTzv5BjIGS0ufgTslfC6dqBoU7tw8NKUDHg28bPJlL0vGVWVgbTg","types"=>["restaurant","food","establishment"]},{"formatted_address"=>"483GeorgeStreet,SydneyNSW,Australia","events"=>[{"event_id"=>"7lH_gK1GphU","summary"=>"GoogleMapsDeveloperMeetup=>Rockin'outwiththePlacesAPI","url"=>"https=>//developers.google.com/places"}],"geometry"=>{"location"=>{"lat"=>-33.8731950,"lng"=>151.2063380}},"icon"=>"http=>//maps.gstatic.com/mapfiles/place_api/icons/civic_building-71.png","id"=>"017049cb4e82412aaf0efbde890e82b7f2987c16","name"=>"ChinatownSydney","rating"=>4.0,"reference"=>"CnRuAAAAsLNeRQtKD7TEUXWG6gYD7ByOVKjQE61GSyeGZrX-pOPVps2BaLBlH0zBHlrVU9DKhsuXra075loWmZUCbczKDPdCaP9FVJXB2NsZ1q7188pqRFik58S9Z1lcWjyVoVqvdUUt9bDMLqxVT4ENmolbgBIQ9Wy0sgDy0BgWyg5kfPMHCxoUOvmhfKC-lTefXGgnsRqEQwn8M0I","types"=>["city_hall","park","restaurant","doctor","train_station","local_government_office","food","health","establishment"]}],"status"=>"OK"}

	userRouteBoxer = [[[-33.86,152],[-33.88,151]],[[0,0],[0,0]]]
	testOutput = JSON.parse(TestingAlgorithm.filterResults(userRouteBoxer, placesList))
    outputString += "Testing filterResults: " + (testOutput == expectedOutput ? "true" : "false") + "\n"
    
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

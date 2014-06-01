require 'json'
module PlacesHelper

    def self.build_url(lat, long, radius, type )
        a = rand(4)
        case a
        when 0
            api_key = 'AIzaSyARCJzx62dNJ2eYWbV8bu0c6sU8LSF73P0'
        when 1
            api_key = 'AIzaSyDcKmfg6IyjBMtSIREJEeYX1vRX1G_gUEc'
        when 2
            api_key = 'AIzaSyDtdYEXhy0vOMwoPEASOjp10R6DuUKjBv0'
        when 3
            api_key = 'AIzaSyCzGNpS3LtGLe3NVSfSm3IfqUi97DL_Rr4'
        end
        if type == ""
            url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}" + "&radius=#{radius}" + "&types=restaurant" + "&sensor=false&key=#{api_key}"
        else
            url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}&radius=#{radius}&keyword=#{type}+food&sensor=false&key=#{api_key}"
        end
        return url
    end

    def self.query_url(url)
        uri = URI(url)
        http = Net::HTTP.new(uri.host, uri.port)

        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)

        foo = JSON.parse(response.body)
        foo.to_json
    end
=begin
@client = GooglePlaces::Client.new( API_KEY )

def self.query(lat, long, radius, type)
if type == ""
return @client.spots( lat, long, radius: radius )
else
return @client.spots( lat, long, types: type, radius: radius )

end
end
=end

end

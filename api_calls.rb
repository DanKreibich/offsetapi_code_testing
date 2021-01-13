require 'net/http'
require 'json'


# defines the base parameters for calling the API
def base_parameters
  uri = URI('https://api.offset-api.cloud/carbon_activities')
  headers = { 'Content-Type': 'application/json', 'X-API-KEY': 'sk_test_uSTDBzdJPcvEoFvShfYfAE4U' }
  request = Net::HTTP::Post.new(uri, headers)
  [uri, request]
end

# fetches the results ffrom the API
def get_api_result(uri,request)
  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end
end

# extracts grams from API result
def get_grams(result)
  res = JSON.parse(result.body)
  res["items_results"][0]["co2_in_grams"]
end

# Following part aims to return CO2 values of the respective modes of transportation
def request_flight_emissions(origin, destination, booking_class, num_of_travelers)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: 'flight',
        parameters: {
          origin_iata: origin,
          destination_iata: destination,
          booking_class: booking_class,
          number_of_travelers: num_of_travelers
        }
      }
    ]
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end

def request_flight_emissions_csv(flight)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: 'flight',
        parameters: {
          origin_iata: flight[:origin],
          destination_iata: flight[:destination],
          booking_class: flight[:booking_class],
          number_of_travelers: 1
        }
      }
    ]
  }.to_json
  res =  get_api_result(uri, request)
  puts request.body # to check passed values in terminal
  get_grams(res)
end

def request_car_emissions_distance_type(distance, fuel_type, car_type)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "car",
        parameters: {
          distance_in_km: distance,
          fuel_type: fuel_type,
          car_type: car_type},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_car_emissions_distance_type(40, "petrol", "medium")

def request_car_emissions_distance_co2(distance, co2)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "car",
        parameters: {
          co2_grams_per_km: co2,
          distance_in_km: distance},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_car_emissions_distance_co2(100, 200)

def request_car_emissions_address_type(origin, destination, fuel_type, car_type)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "car",
        parameters: {
          origin_address: origin,
          destination_address: destination,
          fuel_type: fuel_type  ,
          car_type: car_type},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_car_emissions_address_type("Weidenstieg 16, 20259 Hamburg, Germany", "Rosenthalerstraße 32, 13347 Berlin, Germany", "petrol", "medium")

def request_car_emissions_address_co2(origin, destination, co2)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "car",
        parameters: {
          origin_address: origin,
          destination_address: destination,
          co2_per_km: co2},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_car_emissions_address_co2("Weidenstieg 16, 20259 Hamburg, Germany", "Rosenthalerstraße 32, 13347 Berlin, Germany", 20)

def request_bus_emissions_distance(distance, num_of_travelers)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "bus",
        parameters: {
          distance_in_km: distance,
          number_of_travelers: num_of_travelers},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_bus_emissions_distance(100, 1)

def request_bus_emissions_address(origin, destination)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "bus",
        parameters: {
          origin_address: origin,
          destination_address: destination,
          number_of_passengers: 1},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_bus_emissions_address("Weidenstieg 16, 20259 Hamburg, Germany", "Rosenthalerstraße 32, 13347 Berlin, Germany")

def request_train_emissions_distance(distance, train_type, seat_type, number_of_travelers)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "train",
        parameters: {
          distance_in_km: distance,
          train_type: train_type,
          seat_type: seat_type,
          number_of_travelers: number_of_travelers},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_train_emissions_distance(100, 'regional', 'second_class', 1)

def request_train_emissions_address(origin, destination, train_type, seat_type, number_of_travelers)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "train",
        parameters: {
          distance_in_km: distance,
          train_type: train_type,
          seat_type: seat_type,
          number_of_travelers: number_of_travelers},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_train_emissions_address(100, 'regional', 'second_class', 1)


def request_parcel_emissions_distance(distance, weight, shipping_method)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "parcel",
        parameters: {
          distance_in_km: distance,
          weight_in_kg: weight,
          shipping_method: shipping_method},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_parcel_emissions_distance(100, 2, "express")

def request_hotel_emissions(stars, room_type, nights)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "hotel",
        parameters: {
          stars: stars,
          room_type: room_type,
          number_of_nights: nights},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_hotel_emissions(3, "single", 2)

def request_cruise_emissions(nights)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "cruise",
        parameters: {
          number_of_nights: nights},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
end
# puts request_cruise_emissions(3)

def request_general_emissions(co2)
  uri = base_parameters[0]
  request = base_parameters[1]
  request.body = {
    items: [
      {
        carbon_activity_type: "general",
        parameters: {
          co2_amount_in_grams: co2},
      }
    ],
  }.to_json
  res =  get_api_result(uri, request)
  get_grams(res)
  res
  answer = JSON.parse(res.body)
end
puts request_general_emissions(100000)


# The following part deals with puchasing and offsetting carbon activities after they got calculated through the API
def purchase_offset(id)
  uri = URI("https://api.offset-api.cloud/carbon_activities/#{id}/purchase")
  headers = { 'Content-Type': 'application/json', 'X-API-KEY': 'sk_test_uSTDBzdJPcvEoFvShfYfAE4U' }
  request = Net::HTTP::Put.new(uri, headers)
  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end
end

def refund_offset(id)
  uri = URI("https://api.offset-api.cloud/carbon_activities/#{id}/refund")
  headers = { 'Content-Type': 'application/json', 'X-API-KEY': 'sk_test_uSTDBzdJPcvEoFvShfYfAE4U' }
  request = Net::HTTP::Put.new(uri, headers)
  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end
end



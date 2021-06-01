# program will get CSV as input and create a new csv file including co2 values
require 'csv'
require_relative 'api_calls'
require 'byebug'

# change to respective CSV
file = 'logistics_cloud.csv'
file_base_name = file.split('.').first

def run_program(file, file_base_name)
  input_array = get_data_truck(file) # ADJUST TO SPECIFIC FILE
  output_array = get_carbon_data_truck(input_array) # ADJUST TO SPECIFIC ACTIVITY
  save_to_csv(output_array, file_base_name)
end

def get_data_flight(file)
  input_array = []
  CSV.foreach(file, headers: true) do |row|
    values = row.to_s.split(';')
    locations = values[0].split('-')
    origin = locations[0]
    destination = locations[1]
    booking_class = values[1]
    number_of_flights = values[2].to_i

    if booking_class == 'Economy'
      booking_class = 'economy'
    elsif booking_class == 'Business'
      booking_class = 'business'
    elsif booking_class == 'First'
      booking_class = 'first'
    elsif booking_class == 'Premium'
      booking_class = 'premium_economy'
    end

    flight_hash = { origin: origin,
                    destination: destination,
                    booking_class: booking_class,
                    number_of_travelers: 1,
                    number_of_flights: number_of_flights }
    input_array << flight_hash
  end
  input_array
end

def get_data_car(file)
  input_array = []
  CSV.foreach(file, headers: true) do |row|
    values = row.to_s.split(';')
    origin = values[0] + ',' + values[1]
    destination = values[2] + ',' + values[3]
    number_of_trips = values[4]
    fuel_type = 'petrol'
    car_type = 'large'

    car_hash = { origin: origin,
                    destination: destination,
                    fuel_type: fuel_type,
                    car_type: car_type,
                    number_of_trips: number_of_trips.to_i
                }
    input_array << car_hash
  end
  input_array
end

def get_data_truck(file)
  input_array = []
  CSV.foreach(file, headers: true) do |row|
    values = row.to_s.split(';')
    id = values[0]
    origin = values[3]
    destination = values[4]
    weight_in_tonnes = values[1].to_f/1000
    number_of_packages = values[2]

    truck_hash = {  id: id,
                    origin: origin,
                    destination: destination,
                    weight_in_tonnes: weight_in_tonnes,
                    number_of_packages: number_of_packages.to_i
                }

    input_array << truck_hash
  end
  input_array
end


# def get_carbon_data_flights(input_array)
#   output_array = []
#   input_array.each do |flight|
#     output_array << [flight[:origin], flight[:destination], flight[:booking_class], request_flight_emissions_csv(flight) * flight[:number_of_flights]]
#   end
#   output_array
# end

# def get_carbon_data_car(input_array)
#   output_array = []
#   input_array.each do |car_ride|
#     puts car_ride[:origin] + " " + car_ride[:destination] + " " +  car_ride[:fuel_type] + " " +  car_ride[:car_type]
#     output_array << [car_ride[:origin], car_ride[:destination], car_ride[:number_of_trips], request_car_emissions_address_type(car_ride[:origin], car_ride[:destination], car_ride[:fuel_type], car_ride[:car_type]) * car_ride[:number_of_trips]]
#   end
#   output_array
# end

def get_carbon_data_truck(input_array)
  output_array = []
  input_array.each do |truck_ride|
    puts truck_ride[:id] + " | " +  truck_ride[:weight_in_tonnes].to_s + " | " + truck_ride[:origin] + " | " + truck_ride[:destination] + " | " +  truck_ride[:number_of_packages].to_s
    output_array << [truck_ride[:id], truck_ride[:weight_in_tonnes], truck_ride[:number_of_packages], truck_ride[:origin], truck_ride[:destination], request_truck_address_emissions(truck_ride[:weight_in_tonnes], truck_ride[:origin], truck_ride[:destination]) * truck_ride[:number_of_packages]]
  end
  output_array
end

def save_to_csv(output_array, file__base_name)
  CSV.open(file__base_name + "_results.csv", 'wb') do |csv|
    csv << ['id', 'weight_in_tonnes', 'number_of_packages', 'origin', 'destination', 'CO2_in_grams'] # <-- ADJUST if needed
    output_array.each { |x| csv << x }
  end
end

run_program(file, file_base_name)

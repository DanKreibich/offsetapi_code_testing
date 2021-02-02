# program will get CSV as input and create a new csv file including co2 values
require 'csv'
require_relative 'api_calls'

# change to respective CSV
file = 'fiege_2019.csv'
file_base_name = file.split('.').first

def run_program(file, file_base_name)
  input_array = get_data(file)
  output_array = get_carbon_data(input_array)
  save_to_csv(output_array, file_base_name)
end

def get_data(file)
  input_array = []
  CSV.foreach(file, headers: true) do |row|
    values = row.to_s.split(';')
    locations = values[0].split('-')
    origin = locations[0]
    destination = locations[1]
    booking_class = values[1]
    number_of_flights = values[2].to_i

    if booking_class == 'Eco'
      booking_class = 'economy'
    elsif booking_class == 'Business'
      booking_class = 'business'
    elsif booking_class == 'First'
      booking_class = 'first'
    elsif booking_class == 'PremiumEco'
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

def get_carbon_data(input_array)
  output_array = []
  input_array.each do |flight|
    output_array << [flight[:origin], flight[:destination], flight[:booking_class], request_flight_emissions_csv(flight) * flight[:number_of_flights]]
  end
  output_array
end

def save_to_csv(output_array, file__base_name)
  CSV.open(file__base_name + "_results.csv", 'wb') do |csv|
    csv << ['origin', 'destination', 'class', 'CO2 in grams']
    output_array.each { |x| csv << x }
  end
end

run_program(file, file_base_name)

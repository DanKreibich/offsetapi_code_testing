require_relative 'api_calls'

car_type = {
            small: {petrol: 6.7, diesel: 5.4, electric: 16.6},
            medium: {petrol: 7.8, diesel: 6.1, electric: 21.5},
            large: {petrol: 9.6, diesel: 7.7, electric: 27.1}}

car_emission_factor = {
                        petrol: 2780,
                        diesel: 3170,
                        electric: 508}

train_detour_factor = {
                  public: 1,
                  high_speed: 1.2,
                  regional: 1.35,
                  intercity: 1.5}

train_seat_class = {
                first_class: 1.2,
                second_class: 1}

train_emission_factor = {
                  high_speed: 38,
                  regional: 48,
                  intercity: 52}

shipping_method = {
                  normal: 0.506,
                  express: 1.4}

stars = {
          1 => 18190,
          2 => 20030,
          3 => 22620,
          4 => 25540,
          5 => 27060}

room_type = {
              single: 1,
              double: 1.3,
              suite: 1.5}

def test_flight
  puts "+++ FLIGHT +++"
  test_arr = [
              ['HAM', 'ZAG', 'economy', 1, 93540],
              ['HAM', 'ZAG', 'premium_economy', 1, 1260000],
              ['HAM', 'ZAG', 'business', 1, 1150000],
              ['HAM', 'MLA', 'economy', 1, 93540],
              ['HAM', 'MLA', 'premium_economy', 1, 1260000],
              ['HAM', 'MLA', 'business', 1, 1150000],
              ['HAM', 'PDL', 'economy', 1, 93540],
              ['HAM', 'PDL', 'premium_economy', 1, 1260000],
              ['HAM', 'PDL', 'business', 1, 1150000]
              ]
  test_arr.each do |flight|
    compensaid_value = flight[4]
    api_result = request_flight_emissions(flight[0], flight[1], flight[2], flight[3])
    if compensaid_value == api_result
      puts "Correct! Expected: #{compensaid_value}, Received: #{api_result} (array = #{flight})"
    else
      puts "False! Expected: #{compensaid_value}, Received: #{api_result} (array = #{flight})"
    end
  end
  puts ""
  puts ""
end

def test_car_distance_type(type, car_emission_factor)
  puts "+++ CAR - distance, type +++"

  emission_factor = car_emission_factor
  car_type = type

  test_arr = [
              [50, 'petrol', 'medium'],
              [789, 'electric', 'large'],
              [50, 'diesel', 'small']
              ]

  test_arr.each do |ride|
    calculation = ride[0] * car_type[ride[2].to_sym][ride[1].to_sym] * emission_factor[ride[1].to_sym]
    api_result = request_car_emissions_distance_type(ride[0], ride[1], ride[2])
    if calculation.to_i/100 == api_result
      puts "Correct! Expected: #{calculation}, Received: #{api_result} (array = #{ride})"
    else
      puts "False! Expected: #{calculation}, Received: #{api_result} (array = #{ride})"
    end
  end
  puts ""
  puts ""
end


def test_bus_emissions_distance
  puts "+++ BUS - distance +++"

  test_arr = [
              [250, 1],
              [789, 2],
              [50, 4]
              ]

  test_arr.each do |ride|
    calculation = ride[0] * 89 * ride[1]
    api_result = request_bus_emissions_distance(ride[0], ride[1])
    if calculation == api_result
      puts "Correct! Expected: #{calculation}, Received: #{api_result} (array = #{ride})"
    else
      puts "False! Expected: #{calculation}, Received: #{api_result} (array = #{ride})"
    end
  end
  puts ""
  puts ""
end


def test_train_emissions_distance(detour, seat, emission)
  puts "+++ TRAIN - distance +++"

  detour_factor = detour
  seat_class = seat
  emission_factor = emission

  test_arr = [
              [200, 'intercity', 'second_class', 1],
              [200, 'regional', 'first_class', 2],
              [584, 'high_speed', 'second_class', 1]
              ]

  test_arr.each do |ride|
    calculation = ride[0] * detour_factor[ride[1].to_sym] * emission_factor[ride[1].to_sym] * seat_class[ride[2].to_sym] * ride[3]
    api_result = request_train_emissions_distance(ride[0], ride[1], ride[2], ride[3])
    if calculation.to_i == api_result.to_i
      puts "Correct! Expected: #{calculation.to_i}, Received: #{api_result} (array = #{ride})"
    else
      puts "False! Expected: #{calculation.to_i}, Received: #{api_result} (array = #{ride})"
    end
  end
  puts ""
  puts ""
end


def test_parcel_emissions_distance(shipping)
  puts "+++ Parcel - distance +++"

  shipping_method = shipping
  shipping_uncertainty_factor = 1.5

  test_arr = [
              [584, 2, 'express'],
              [8000, 3, 'normal'],
              [54, 10, 'normal']
              ]

  test_arr.each do |parcel|
    calculation = parcel[0] * parcel[1] * shipping_method[parcel[2].to_sym] * shipping_uncertainty_factor
    api_result = request_parcel_emissions_distance(parcel[0], parcel[1], parcel[2])
    if calculation == api_result
      puts "Correct! Expected: #{calculation.to_i}, Received: #{api_result} (array = #{parcel})"
    else
      puts "False! Expected: #{calculation.to_i}, Received: #{api_result} (array = #{parcel})"
    end
  end
  puts ""
  puts ""
end

def test_hotel_emissions(star, room)
  puts "+++ Hotel +++"

  stars = star
  room_type = room

  test_arr = [
              [1, 'single', 7], [2, 'single', 1], [3, 'single', 1], [4, 'single', 1], [5, 'single', 1],
              [1, 'double', 7], [2, 'double', 1], [3, 'double', 1], [4, 'double', 1], [5, 'double', 1],
              [1, 'suite', 1], [2, 'suite', 1], [3, 'suite', 1], [4, 'suite', 1], [5, 'suite', 1]
              ]

  test_arr.each do |hotel|
    calculation = stars[hotel[0]] * room_type[hotel[1].to_sym] * hotel[2]
    api_result = request_hotel_emissions(hotel[0], hotel[1], hotel[2])
    if calculation == api_result
      puts "Result: #{calculation.to_i}, Received: #{api_result} (array = #{hotel})"
    else
      puts "False! Expected: #{calculation.to_i}, Received: #{api_result} (array = #{hotel})"
    end
  end
  puts ""
  puts ""
end

def test_cruise_emissions
  puts "+++ Cruise +++"

  test_arr = [4, 14, 12]

  test_arr.each do |trip|
    calculation = trip * 293500
    api_result = request_cruise_emissions(trip)
    if calculation == api_result
      puts "Correct! Expected: #{calculation.to_i}, Received: #{api_result} (nights = #{trip})"
    else
      puts "False! Expected: #{calculation.to_i}, Received: #{api_result} (nights = #{trip})"
    end
  end
  puts ""
  puts ""
end


# test_flight
# test_car_distance_type(car_type, car_emission_factor)
# test_bus_emissions_distance
# test_train_emissions_distance(train_detour_factor, train_seat_class, train_emission_factor)
# test_parcel_emissions_distance(shipping_method)
test_hotel_emissions(stars, room_type)
# test_cruise_emissions

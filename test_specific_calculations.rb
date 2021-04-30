require_relative 'api_calls'

#puts 'parameters: ' + "('Madrid-Puerta de Atocha', 'Barcelona-Sants', 'high_speed', 'second_class', 1)"
#puts 'CO2 grams:'
#puts request_train_emissions_address('Madrid-Puerta de Atocha', 'Barcelona-Sants', 'high_speed', 'second_class', 1)
#puts ''
#
#puts 'parameters: ' + "('Madrid-Puerta de Atocha, Spain', 'Barcelona-Sants, Spain', 'high_speed', 'second_class', 1)"
#puts 'CO2 grams:'
#puts request_train_emissions_address('Madrid-Puerta de Atocha, Spain', 'Barcelona-Sants, Spain', 'high_speed', 'second_class', 1)
#puts ''
#
#puts 'parameters: ' + "('Madrid', 'Barcelona', 'high_speed', 'second_class', 1)"
#puts 'CO2 grams:'
#puts request_train_emissions_address('Madrid', 'Barcelona', 'high_speed', 'second_class', 1)
#puts ''
#
#puts 'parameters: ' + "('Madrid, Spain', 'Barcelona, Spain', 'high_speed', 'second_class', 1)"
#puts 'CO2 grams:'
#puts request_train_emissions_address('Madrid, Spain', 'Barcelona, Spain', 'high_speed', 'second_class', 1)
#puts ''
#
#puts 'parameters: ' + "('Weidenstieg 16, 20259 Hamburg, Germany', 'Rosenthalerstraße 32, 13347 Berlin, Germany', 'petrol', 'medium')"
#puts 'CO2 grams:'
#puts request_car_emissions_address_type('Weidenstieg 16, 20259 Hamburg, Germany', 'Rosenthalerstraße 32, 13347 Berlin, Germany', 'petrol', 'medium')
#puts ''

puts 'parameters: ' + "('46399, bocholt', 'humboldt - gremberg, cologne', 'petrol', 'medium')"
puts 'CO2 grams:'
puts request_car_emissions_address_type('46399, bocholt', 'humboldt - gremberg, cologne', 'petrol', 'medium')
puts ''

puts 'parameters: ' + "('48161, münster', 'sankt peter-ording, nordfriesland', 'petrol', 'medium')"
puts 'CO2 grams:'
puts request_car_emissions_address_type('48161, münster', 'sankt peter-ording, nordfriesland', 'petrol', 'medium')
puts ''

puts 'parameters: ' + "('24790, schülldorf', 'gifhorn, gifhorn', 'petrol', 'medium')"
puts 'CO2 grams:'
puts request_car_emissions_address_type('24790, schülldorf', 'gifhorn, gifhorn', 'petrol', 'medium')
puts ''



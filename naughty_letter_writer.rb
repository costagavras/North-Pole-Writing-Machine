require 'erb'

kids_data = File.read('data/kids-data.txt')
naughty_letter = File.read('templates/naughty_letter_template.txt.erb')

kids_data.each_line do |kid|

  kid_data_array = kid.split
  name     = kid_data_array[0]
  behavior = kid_data_array[1]
  toys     = kid_data_array[2..7]
  toys.delete("Kaleidoscope")
  random = rand(toys.length) # random index
  toy_got = toys[random] # random toy saved
  toys.delete_at(random) # taking random toy out of the toys array
  toys_not_got = toys[0..toys.length - 2]
  toys_not_got_last = toys.last
  infraction = kid_data_array[14..-1]

  next unless behavior == 'naughty' # breaking part of the loop below if not *naughty*

  filename    = 'letters/naughty/' + name + '.txt'
  letter_text = ERB.new(naughty_letter, nil, '-').result(binding)

  puts "Writing #{filename}."
  File.write(filename, letter_text)

end

puts 'Done!'

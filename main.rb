=begin

    Allen Oyieke
    Neural Network (Back propagation)
    CSC 323 - Machine Learning

=end

require './NeuralNetwork' 

net = NeuralNetwork.new(256, 30, 10, 0.3, 0.5) # initialize network format input hidden output node learning rate and momentum

matrix = IO.readlines('./data/random.dataset').map { |line| line.split.map(&:to_i) }
training_data = []

matrix.each do |row|
  training_data << [row[0..255], row[-10..-1]]
end

puts "[+] Kindly wait training in session!"

1000.times do |iterations|
    #pp net.train(training_data.sample(60), iterations) # Train algorithm on data
    net.train(training_data.sample(60), iterations) # Train algorithm on data
end
puts "[+] End of training in session!"


puts "\n[+] Begining Tests"
net.test(training_data.sample(500)) # Test algorithm


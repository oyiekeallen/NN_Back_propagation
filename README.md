# Neural network

Simple implementaion of neural network (bp) in ruby


## Exection 
> ruby mai.rb

## Modifications
To use another dataset kindly change value in main.rb line 13
> matrix = IO.readlines('./data/random.dataset').map { |line| line.split.map(&:to_i) }

To change algorithm working parameters, kindly change value in main.rb line 11
>net = NeuralNetwork.new(256, 30, 10, 0.3, 0.5) # initialize network format: values(input nodes, hidden nodes ,output node,learning rate , momentum)

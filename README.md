# Neural network - Back Propagation

Simple implementaion of neural network (bp) written in ruby


## Exection 
> ruby mai.rb

## Making Modifications

To use another dataset kindly change value in main.rb line 13
> matrix = IO.readlines('./data/random.dataset').map { |line| line.split.map(&:to_i) }

To change algorithm working parameters, kindly change value in main.rb line 11
>net = NeuralNetwork.new(256, 30, 10, 0.3, 0.5) # initialize network format: values(input nodes, hidden nodes ,output node,learning rate , momentum)


## License

Copyright 2018 Allen Oyieke 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

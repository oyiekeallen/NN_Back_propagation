require 'pp' # pretty printer

# Main class containg major functions required in a neural network
class NeuralNetwork

  def self.activation(x)
    # Sigmoid activation function
    1.0/(1.0+Math.exp(-1.0 * x)) 
  end

  def self.activation_derivative(x) 
    # Derivative of the sigmoid activation function
    self.activation(x) * (1.0-self.activation(x))
  end
  
  def self.create_matrix(rows, columns, val=0.0)
    m = []
    rows.times do |i|
      m << [val] * columns
    end
    m
  end

  # Function to get things ready -> "early bird cathes the worms"
  def initialize(inputNodes, hiddenNodes, outputNodes, learningRate=0.3, momentum=0.2)
    # Make sure we add the bias node to the input
    @inputNodes = inputNodes + 1
    @hiddenNodes = hiddenNodes
    @outputNodes = outputNodes

    @learningRate = learningRate
    @momentum = momentum

    @w_1 = NeuralNetwork::create_matrix(@inputNodes, @hiddenNodes, 0.0)
    @w_2 = NeuralNetwork::create_matrix(@hiddenNodes, @outputNodes, 0.0)
    
    # Randomize the values of Nthe nodes [-0.5, 0.5]
    @w_1.map! { |arr| arr.map { |v| rand(-0.5..0.5) } }
    @w_2.map! { |arr| arr.map { |v| rand(-0.5..0.5) } }

    # It helps to store the current state of node activations
    @activation_input = [1.0] * @inputNodes
    @activation_hidden = [1.0] * @hiddenNodes
    @activation_output = [1.0] * @outputNodes

    @din = NeuralNetwork::create_matrix(@inputNodes, @hiddenNodes, 0.0)
    @dout = NeuralNetwork::create_matrix(@hiddenNodes, @outputNodes, 0.0)

    puts "\n================================================================================================\n[+]Weights from input to hidden nodes [#{@inputNodes}x#{@hiddenNodes}] has been initialized with small random values"
    puts "[+]Weights from hidden to output nodes [#{@hiddenNodes}x#{@outputNodes}] has been nitialized to small random values\n================================================================================================\n"

    puts "Neural network initialized with values \n \t Input Nodes:[{#{@inputNodes}]\t Hidden Nodes: [#{@hiddenNodes}]\t Output Nodes: [#{@outputNodes}]} \n--------------------------------------------------------------------------------\n"
    puts ""

  end

  # Function to give predition on a input dataset
  def predict(input)
    # Perform forward propagation to predict output
    
    # Activation on input nodes should simply be the input
    @activation_input[-1] = 1 # set bias node's activation to 1
    @activation_input[0..-2] = input
    
    # Compute the weighted sum into each hidden node
    @hiddenNodes.times do |x|
      s = 0.0
      @inputNodes.times do |i|
        s = s + (@activation_input[i] * @w_1[i][x])
      end
      # update activation for the hidden layer
      @activation_hidden[x] = NeuralNetwork::activation(s)
    end
    
    # Now compute the weighted sum into each output node
    @outputNodes.times do |x|
      s = 0.0
      @hiddenNodes.times do |h|
        s = s + (@activation_hidden[h] * @w_2[h][x])
      end
      # update activations for the output layer
      @activation_output[x] = NeuralNetwork::activation(s)
    end

    @activation_output

  end
   
 
  def backpropagation(desired_output)
      <<-DOC
       Function to perform back propagation on data.
            - Compute error at the output nodes
      DOC
  
    delta_output = [0.0] * @outputNodes
    @outputNodes.times do |x|
      e = desired_output[x] - @activation_output[x]
      delta_output[x] = NeuralNetwork::activation_derivative(@activation_output[x]) * e
    end
  
    # compute error at hidden nodes
    delta_hidden = [0.0] * @hiddenNodes
    @hiddenNodes.times do |h|
      err = 0.0
      @outputNodes.times do |o|
        err = err + delta_output[o] * @w_2[h][o]
      end
      delta_hidden[h] = NeuralNetwork::activation_derivative(@activation_hidden[h]) * err
    end

    # update weight step for hidden -> output
    @hiddenNodes.times do |h|
      @outputNodes.times do |o|
        delt = delta_output[o] * @activation_hidden[h]
        @w_2[h][o] = @w_2[h][o] + @learningRate * delt + @momentum * @dout[h][o]
        @dout[h][o] = delt
      end
    end

    # update weight step for input -> hidden
    @inputNodes.times do |i|
      @hiddenNodes.times do |h|
        delt = delta_hidden[h] * @activation_input[i]
        @w_1[i][h] = @w_1[i][h] + @learningRate * delt + @momentum * @din[i][h]
        @din[i][h] = delt
      end
    end

    # Evaluate new network error
    err = 0.0
    desired_output.each_with_index do |ex, index|
      err = err + 0.5 * (ex - @activation_output[index]) ** 2
    end
   
    err
  end


  def test(examples)
      <<-DOC
      Function to run simple test on examples
      DOC
    good = 0.0
    examples.each do |example|
      arr = predict(example[0])
      arr.map! { |val| (val==arr.max)? 1 : 0 } 
      good = good + 1 if(arr == example[1])
      puts "#{example[1]} => #{arr} [#{arr == example[1] ? "\t[o-o] (GOOD) " : "\t[*-*] (BAD) "}"
    end
    puts "\n-------------------------------------------------------------------------\nAccuracy of training  = #{(good/examples.length)*100}%"
  end

  
  def train(examples, iteration)
      <<-DOC
      Function to train algo
      DOC
    epoch = 0
    error = 1.0
    
    while error > 0.01
      error = 0.0
      epoch = epoch + 1
      examples.each do |ex|
        predict(ex[0])
        error = error + backpropagation(ex[1])
      end
      if epoch % 1 == 0
        #puts "Epoch: #{iteration}\t Error: #{error}"
      end
    end
  end
  
  
end

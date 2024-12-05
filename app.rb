# Simulates a Galton board with the given number of rows and balls.
#
# @param rows [Integer] The number of rows in the Galton board.
# @param balls [Integer] The number of balls to drop.
# @return [Array<Integer>] The distribution of balls in the bins.
def simulate_galton_board(rows, balls)
  distribution = Array.new(rows + 1, 0)

  balls.times do
    distribution[(0...rows).inject(0) { |bin, _| bin + rand(0..1) }] += 1
  end  

  distribution
end

# Calculates the theoretical distribution for a Galton board.
#
# @param rows [Integer] The number of rows in the Galton board.
# @param balls [Integer] The number of balls dropped.
# @return [Array<Float>] The theoretical distribution of balls in the bins.
def theoretical_distribution(rows, balls)
  (0..rows).map { |k| balls * (1.0 / 2**rows) * choose(rows, k) }
end

# Calculates the binomial coefficient "n choose k".
#
# @param n [Integer] The total number of items.
# @param k [Integer] The number of items to choose.
# @return [Integer] The binomial coefficient.
def choose(n, k)
  return 0 if k < 0 || k > n
  return 1 if k == 0 || k == n
  (1..k).inject(1) { |result, i| result * (n - i + 1) / i }
end

# Get user input for rows and balls, with error handling
def get_user_input
  begin
    print "Enter the number of rows: "
    rows = gets.chomp.to_i
    print "Enter the number of balls: "
    balls = gets.chomp.to_i
    raise ArgumentError, "Invalid input. Please enter positive integers." unless rows > 0 && balls > 0
  rescue ArgumentError => e
    puts e.message
    retry
  end
  [rows, balls]
end

# Main execution
rows, balls = get_user_input

simulated_distribution = simulate_galton_board(rows, balls)
theoretical_dist = theoretical_distribution(rows, balls)

puts "Galton Board Simulation:"

# Find the maximum frequency in the simulated distribution for scaling
max_freq = simulated_distribution.max

# Print the simulated distribution using '#' characters
simulated_distribution.each_with_index do |freq, bin|
  puts "#{bin}: " + "#" * (freq * 20 / max_freq) # Scale for visualization
end

puts "\nTheoretical Distribution:"
puts theoretical_dist.join(", ")
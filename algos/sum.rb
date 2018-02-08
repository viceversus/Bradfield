def sum(n)
  sum = 0
  1.upto(n) do |i|
    sum += i
  end

  sum
end

puts sum(10)

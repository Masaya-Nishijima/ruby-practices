def pattern_selecter(num)
  if ((num % 3) == 0) && ((num % 5) ==0)
    "FizzBuzz"
  elsif (num % 3) == 0
    "Fizz"
  elsif (num % 5) == 0
    "Buzz"
  else
    num
  end
end


20.times do |num|
  num += 1
  puts pattern_selecter(num)
end

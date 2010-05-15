def fibonacci(n)
  a,b = 0,1
  n.times do
    printf("%d\n", a)
    a,b = b,a+b
  end
end
# def fibonacci(n)
#   p=proc{|x|x<2?x:p[x-1]+p[x-2]};p[n]
# end

puts fibonacci(ARGV[0].to_i)

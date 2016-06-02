require "./factory.rb"

Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

c = Customer.new("Dave", "123 Main")

puts c.greeting
puts c.name
puts c.address

#test []
puts c["name"]

#test []=
c["name"] = "Vasya"
puts c["name"]

#test values
puts c.values

#test ==
d = Customer.new("Vasya", "123 Main")
e = Customer.new("Brave", "123 Main")
puts c == e
puts c == d

#test values_at
puts d.values_at(1)

#test to_h
puts d.to_h

#test members
puts d.members

#test lenght
puts d.lenght

#test select
puts d.select {|v| v == "Vasya"}

#test eql?
puts c.eql? d

#test each
c.each {|x| puts x }

#test each_pair
c.each_pair {|name, value| puts("#{name} => #{value}") }
print c.members
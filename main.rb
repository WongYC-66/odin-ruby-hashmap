require_relative "hashmap"

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

test.set('moon', 'silver')
test.set('lion', 'overwrite')
test.set('frog', 'overwrite')

puts test.buckets

puts test.get("elephant")
puts test.get("moon")
puts test.get("frog")

puts test.has?("elephant")
puts test.length
puts test.remove("elephant")
puts test.has?("elephant")
puts test.get("elephant")
puts test.length

p test.keys
puts
p test.values
puts
p test.entries
puts
test.clear()
p test.buckets




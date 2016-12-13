require_relative('../models/pizza')
pizza1 = Pizza.new({
  "first_name" => "Val",
  "last_name" => "Dryden",
  "topping" => "Pepperoni",
  "quantity" => 1
})

pizza2 = Pizza.new({
  "first_name" => "Will",
  "last_name" => "Robertson",
  "topping" => "Italian Sausage",
  "quantity" => 12
})

pizza1.save
pizza2.save

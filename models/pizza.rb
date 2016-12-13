require_relative('../db/sql_runner')

class Pizza

  attr_reader( :first_name, :last_name, :topping, :quantity, :id )

  def initialize( options )
    @id = nil || options['id'].to_i
    @first_name = options['first_name']
    @last_name = options['last_name']
    @topping = options['topping']
    @quantity = options['quantity'].to_i
  end

  def pretty_name()
    return @first_name.concat(" #{@last_name}")
  end

  def total()
    return @quantity * 10
  end

  def save()
    sql = "INSERT INTO pizzas (
      first_name,last_name,topping,quantity ) VALUES 
      ('#{ @first_name }','#{ @last_name }','#{ @topping }','#{ @quantity }') 
      RETURNING *"
    pizza_data = SqlRunner.run(sql)
    @id = pizza_data.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM pizzas"
    pizzas = SqlRunner.run( sql )
    result = pizzas.map { |pizza| Pizza.new( pizza ) }
    return result
  end

  def self.find( id )
    sql = "SELECT * FROM pizzas WHERE id=#{id}"
    pizza = SqlRunner.run( sql )
    result = Pizza.new( pizza.first )

    return result
  end

  def self.update( options )
    sql = "UPDATE pizzas SET
          first_name='#{options['first_name']}',
          last_name='#{options['last_name']}',
          topping='#{options['topping']}',
          quantity='#{options['quantity']}'
          WHERE id='#{options['id']}'"
    SqlRunner.run( sql )
  end

  def self.destroy( id )
    sql = "DELETE FROM pizzas WHERE id=#{id}"
    SqlRunner.run( sql )
  end

end

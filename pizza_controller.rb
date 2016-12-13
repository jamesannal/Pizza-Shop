require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('./models/pizza.rb')

# get all pizzas
get '/pizzas' do
  @pizzas = Pizza.all
  erb(:index) # sinatra always looks for erb files in the views folder so no further info needed
end

# new pizza form
get '/pizzas/new' do
  erb(:new)
end

# actually make a pizza
post '/pizzas' do
  #return params.to_s #this was just to prove how it works.need to get rid of anything else if you want to do this again.
  @pizza = Pizza.new( params ) #because of the way the initialize method was written, params can be passed in just like this without the need to put each parameter (eg topping) seperately
  @pizza.save()
  erb(:create)
end

# get / find a pizza by ID
get '/pizzas/:id' do
  id = params[:id]
  @pizza = Pizza.find(id)
  erb(:show)
end

# get edit pizza form
get '/pizzas/:id/edit' do
  @pizza = Pizza.find(params[:id])
  erb(:edit)
end

# update a pizza by id
# although this is a post, it would have been a put. Modern browsers no longer support put or delete.
post '/pizzas/:id' do
  Pizza.update(params)
  redirect to "/pizzas/#{ params[:id]}" # redirects back to show page
end

# delete a pizza by id
# same as put - no longer supported as verb 'delete'
post '/pizzas/:id/delete' do
  Pizza.destroy( params[:id] )
  redirect to('/pizzas')
end
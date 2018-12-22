$stdout.sync = true

require 'sinatra'
require 'mongo'
require './lib/products_storage'

set :views, settings.root + '/templates'

connection = Mongo::Client.new(['127.0.0.1'], database: 'shop')
products_storage = Products.new(connection)


get '/' do
  erb :welcome
end

get '/products' do
  products = products_storage.all
  erb :products, locals: { products: products }
end

get '/products/:id' do
  product = products_storage.find(params[:id])
  erb :product, locals: { products: product }
end

get '/add/product' do
  erb :product_add
end

post '/add/product' do
  products_storage.create(params[:title], params[:about], params[:price])
  redirect to('/products')
end

require 'mongo'
require 'bson'

Mongo::Logger.logger.level = Logger::FATAL

class Products

  def initialize(client)
    @client = client
  end

  def all
    @client[:products].find
  end

  def create(title, about, price)
    @client[:products].insert_one({ title: title, about: about, price: price })
  end

  def find(product_id)
    @client[:products].find({ _id: BSON::ObjectId(product_id) }).first
  end
end

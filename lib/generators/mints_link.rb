class MintsLink
  def initialize
    @host = ENV['MONGO_HOST'] || '127.0.0.1'
    @database = ENV['MONGO_DATABASE'] || 'mints'
    @port = ENV['MONGO_PORT'] || '27017'
    @client = Mongo::Client.new([ "#{@host}:#{@port}" ], :database => @database)
    @short_links = @client[:short_links]
    @sl_visits = @client[:sl_visits]
    generate_indexes
  end

  def generate(url)
    code = random_string.upcase
    collection = @short_links
    doc = {
      url: url,
      code: code
    }

    result = collection.insert_one(doc)
    if result.n === 1
      code
    else
      false
    end
  end

  def get_url(code)
    collection = @short_links
    record = collection.find( { 'code' => code } ).first
    record["url"]
  end

  def visit(code, url, contact_id, user_agent, ip)
    collection = @sl_visits
    doc = {
      code: code,
      url: url,
      contact_id: contact_id,
      user_agent: user_agent,
      ip: ip
    }
    result = collection.insert_one(doc)
    result.n === 1
  end

  def get_visits(filter, page = 1, page_size = 1000)
    collection = @sl_visits
    collection.find(filter).sort( {_id: 1}).skip(page * page_size - page_size).limit(page_size)
  end

  private
  def random_string(length = 6)
    rand((32 ** length).to_i).to_s(32)
  end

  def generate_indexes
    collection = @short_links
    collection.indexes.create_one({ code: 1 }, {unique: true })
  end
end
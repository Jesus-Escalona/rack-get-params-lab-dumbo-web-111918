class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else @@cart.each { |e| resp.write "#{e}\n" }
      end
    elsif req.path.match(/add/)
      cart_search = req.params["item"]
      resp.write handle_cart_search(cart_search)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_cart_search(cart_search)
    if @@items.include?(cart_search)
      @@cart << cart_search
      return "added #{cart_search}"
    else
      return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end

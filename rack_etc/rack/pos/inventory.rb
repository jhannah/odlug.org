class Inventory
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ['7']]
  end
end
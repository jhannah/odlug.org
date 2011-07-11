class POS
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["#{2 + 2}"]]
  end
end
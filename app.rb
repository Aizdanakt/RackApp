class App

  def call(env)
    [
      200,
      { 'Content-Type' => 'text/plain' },
      ["Welcome abroad!\n"]
    ]
  end
end
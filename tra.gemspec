Gem::Specification.new do |g|
  g.name    = 'tra'
  g.files   = `git ls-files`.split($/)
  g.version = '0.0.2'
  g.summary = 'Erlang-style messaging for Ruby processes'
  g.authors = ['Anatoly Chernow']
end

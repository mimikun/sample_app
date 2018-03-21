Rails.application.routes.draw do
  get 'foo/bar'

  get 'foo/baz'

  root 'application#hello'
end

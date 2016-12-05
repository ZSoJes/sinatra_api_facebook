helpers do
  def auth_hash
    request.env['omniauth.auth']
  end
end
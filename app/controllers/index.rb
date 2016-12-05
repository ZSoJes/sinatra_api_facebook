get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb

  erb :index
end

get '/auth/facebook' do

end

get '/auth/:provider/callback' do
  # env["omniauth.auth"] es un objeto que contiene la información necesaria para crear nuestro usuario después de haber sido autenticados.
  # Esto se lo tenemos que mandar como argumento al método que crea al usuario.
  auth = auth_hash
  user = User.from_omniauth(auth)
  puts "*"*100
  puts "Iniciando sesion"
  puts "*"*100
  # Usa el método que creamos anteriormente para crear a tu usuario
  session[:user_id] = user.uid
  session[:username] = user.name
  session[:oauth_token] = user.oauth_token
  # Inicia su sesión

  # Redirige a su perfil
  
  # redirect to "/user/#{user.uid}"
  redirect to "/user/#{user.uid}"
end

get '/user/:id' do# /ruta/de_tu_perfil/ do

require 'koala'
# Usa el método facebook que creamos para poder establecer la conexión con Facebook Graph API y a partir de ahí, hacer todas las demás peticiones que necesitamos.
@graph = User.new.facebook
profile = @graph.get_object("me")
friends = @graph.get_connections("me", "friends")
# @graph.put_connections("me", "feed", message: "I am writing on my wall!")
# profile = @graph.get_object("me")
# friends = @graph.get_connections("me", "friends")
puts "*-*"*100
puts @graph.put_connections("me", "feed", message: "Soy bien gay!")

# # Three-part queries are easy too!
# puts "*-*"*100
# puts @graph.get_connections("me", "mutualfriends/#{friend_id}")

# Muestra en tu perfil tu imagen, la lista de tus amigos, y tu feed. INVESTIGA cómo hacer éstas peticiones al API.
erb :profile
# end
end

get '/exit' do
  session.delete(:user_id)
  session.delete(:username)
  session.delete(:oauth_token)
redirect to '/'
end
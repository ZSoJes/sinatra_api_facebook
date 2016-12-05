get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  puts "*"*100
  puts session[:user_id]
  puts "mi sesion"
  puts "*"*100
  if session[:user_id] != nil
    redirect to "/user/#{session[:user_id]}"
  end

  erb :index
end

get '/auth/facebook' do

end

get '/auth/:provider/callback' do
  # env["omniauth.auth"] es un objeto que contiene la información necesaria para crear nuestro usuario después de haber sido autenticados.
  # Esto se lo tenemos que mandar como argumento al método que crea al usuario.
  auth = auth_hash
  puts ""
  puts "~"*50
  puts "Iniciando sesion"
  puts "*"*100
  # Usa el método que creamos anteriormente para crear a tu usuario
  user = User.from_omniauth(auth)
  
  # Inicia su sesión
  session[:user_id] = user.uid
  session[:username] = user.name
  session[:oauth_token] = user.oauth_token
  session[:user_pic] = auth.info.image

  # Redirige a su perfil
    redirect to "/user/#{session[:user_id]}"
end

get "/user/:id" do  # /ruta/de_tu_perfil/ do
  if session[:user_id] == nil
    redirect to '/'
  end

  require 'koala'
# Usa el método facebook que creamos para poder establecer la conexión con Facebook Graph API y a partir de ahí, hacer todas las demás peticiones que necesitamos.
  uid = params[:id]

  puts ""
  puts "~"*100
  puts "cargando pagina de usuario"
  puts "~"*100

# Muestra en tu perfil tu imagen, la lista de tus amigos, y tu feed. INVESTIGA cómo hacer éstas peticiones al API.
  @graph = User.new.facebook

 user = @graph.get_object("me")
 friends = @graph.get_connections(user["id"], "friends")

 puts "*"*10
   puts user
   puts friends
 puts "*"*10


  erb :profile
end

post '/mensaje' do
  puts "~"*25
  puts "Enviando mensaje a Facebook"
  puts "~"*25

  mensaje_usuario = params[:msn]
  @graph = User.new.facebook
  @graph.put_wall_post(mensaje_usuario)

  redirect to "/user/#{session[:user_id]}"
end

get '/exit' do
  session.clear
  redirect to '/'
end
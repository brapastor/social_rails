Rails.application.routes.draw do
  devise_for :users, controllers:{
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"
  # get 'main/home'

  authenticated :user do
    root 'main#home'
  end

  unauthenticated :user do
    root 'main#unregistered'
  end

  # 1 mandar una peticion a facebook
  # 2 facebook retorna a nuestra app callback_url
  # 3 procesar la info a fb
  # 4 autenticar al usuario o crear un nuevo usuario

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

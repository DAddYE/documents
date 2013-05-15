module PadrinoWeb
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets

    enable :sessions

    get :index do
      render :index
    end
  end
end

PadrinoWeb::App.controllers :pages do
  get :index do
    render_page 'home'
  end

  get :contribute do
    @selected = :contribute
    render_page 'contribute'
  end

  get :why do
    @selected = :why
    render_page 'why'
  end

  get :changes do
    @selected = :changes
    render_page 'changes'
  end

  get :team do
    @selected = :team
    render_page 'team'
  end
end

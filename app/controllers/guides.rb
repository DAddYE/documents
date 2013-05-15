PadrinoWeb::App.controllers :guides do
  get :index do
    @selected = :guides
    render :document, locals: {document: Guide.find('home'), sidebar_title: 'Guides'}
  end

  get :guide, :map => '/guides/:name' do
    @selected = :guides
    render :document, locals: {document: Guide.find(params[:name]), sidebar_name: 'Guides'}
  end
end

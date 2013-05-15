PadrinoWeb::App.controllers :blog do
  get :index do
    @selected = :blog
    render :post, locals: {post: Post.last, sidebar_title: 'Posts'}
  end

  get :post, :map => '/blog/:name' do
    @selected = :posts
    render :post, locals: {post: Post.find(params[:name]), sidebar_name: 'Posts'}
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    # ユーザをメールアドレスで検索
    @user = User.find_by(email: params[:session][:email].downcase)
    # もしユーザーが見つかった場合は、authenticateメソッドでパスワードが正しいか調べます。
    # パスワードが正しい場合は、session[:user_id]にユーザーIDを入れ、ユーザーの詳細ページにリダイレクトします。
    # パスワードが間違っている場合は’new’テンプレートを表示します。
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    # session[:user_id]をnilにしています。
    # これでサーバーとブラウザの両方でセッションの情報が破棄されます。
    session[:user_id] = nil
    # アプリケーションのルート/にリダイレクトします
    redirect_to root_path
  end
  
  def edit
  end
  
  def update
  end
  
end

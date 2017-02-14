class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    # ログインしていない場合（logged_in?がfalseのとき）のみ処理を行います。
    # store_locationメソッドで、アクセスしようとしたURLを保存しています。
    # ログイン画面のURLにリダイレクトします。
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end

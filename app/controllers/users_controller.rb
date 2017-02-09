class UsersController < ApplicationController
  before_action :check_session, only: [:edit, :update, :show]
  before_action :set_user, only: [:edit, :update, :show]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # # # #
  
  def edit
  end

  def update
    if @user.update(user_params)
      # 保存に成功した場合はプロファイルページへリダイレクト
      redirect_to user_path , notice: '基本情報を編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  # # # #

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:country)
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def check_session
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path , notice: '編集と更新を禁止しています'
    else

    end
  end
  
end

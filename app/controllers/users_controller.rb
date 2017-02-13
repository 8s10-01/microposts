class UsersController < ApplicationController
  before_action :check_session, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
#  before_action :followings, only: [:show]
#  before_action :followers, only: [:show]

  def show
    # ブラウザから指定された:idに関するインスタンスを作成し、
    # UsersControllerのインスタンス変数に代入
    @user = User.find(params[:id])
    # ユーザに紐ついたmicropostsテーブルを作成日時が新しい順に並び替え
    # select "microposts".* from "microposts" order by created_at DESC
    # userControllerのインスタンス変数に代入
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    # Userクラス(model)のインスタンスを作成し、
    # UsersControllerのインスタンス変数に代入
    @user = User.new
  end
  
  def create
    # 送信されたパラメータの内容を
    # 新しいUsersControllerのインスタンス変数に代入
    @user = User.new(user_params)
    if @user.save
      # フラッシュメッセージの表示
      flash[:success] = "Welcome to the Sample App!!"
      # user_path(@user)と同義。詳細画面（show）にリダイレクト
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

  def followings
    # ブラウザから指定された:idに関するインスタンスを作成し、
    # UsersControllerのインスタンス変数に代入
    @user = User.find(params[:id])
    # ユーザに紐ついたfollowing_usersテーブルを
    # userControllerのインスタンス変数に代入
    @followings = @user.following_users.all
    
  end
  
  def followers
    # ブラウザから指定された:idに関するインスタンスを作成し、
    # UsersControllerのインスタンス変数に代入
    @user = User.find(params[:id])
    # ユーザに紐ついたfollowing_usersテーブルを
    # userControllerのインスタンス変数に代入
    @followers = @user.follower_users.all
  end


  private

  # ストロングパラメータで、has_secure_passwordで提供された
  # データベースにない属性を指定しているのに注意。
  # password,password_confirmation
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

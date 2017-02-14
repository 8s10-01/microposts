class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    # フォローする他のユーザIDを受け取り、
    # 見つかったユーザーを引数として、
    # Userモデルのfollowメソッドを実行
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  def destroy
    # 現在のユーザのfollowing_relationshipsテーブルを検索して、
    # 他のユーザをフォローしている場合は、そのユーザーを引数として、
    # Userモデルのunfollowメソッドを実行
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end

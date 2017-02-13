class StaticPagesController < ApplicationController
  # ログインしている場合は、
  # 新しいMicropostクラスのインスタンスをuser_idを紐付けた状態で初期化します。
  # current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じです。
  # 前者の方はcurrent_userのhas_many :micropostsで生成されるbuildメソッドを使用していて、
  # 確実にuser_idが紐付いたデータを作成できるのでこちらを使用するようにしましょう。
  def home
    @micropost = current_user.microposts.build if logged_in?
  end
end

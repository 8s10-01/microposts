class StaticPagesController < ApplicationController
# トップ画面を表示する時
  
  # ログインしている場合は、
  # 新しいMicropostクラスのインスタンスをuser_idを紐付けた状態で初期化します。
  # current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じです。
  # 前者の方はcurrent_userのhas_many :micropostsで生成されるbuildメソッドを使用していて、
  # 確実にuser_idが紐付いたデータを作成できるのでこちらを使用するようにしましょう。
  def home
    if logged_in? # ログインしていれば、実行

      @micropost = current_user.microposts.build
      # インスタンスをuser_idを紐つけた状態で初期化
      # current_user.microposts.build　は、Micropost.new(User_id: current_user.id) と同じ
      # current_user.microposts.build　は、
      # current_userのhas_many :micropostsで生成されるbuildメソッドを利用していて、
      ## 確実にuser_idが紐ついたデータを作成できる。
      
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      # feed_items(user.rb（モデル）で定義している)
      ## 現在のユーザのフォローしているユーザのマイクロポストを取得
      # includes(:user) : ユーザ情報をあらかじめ先読み（プリロード）する
      ## @feed_itemsからアイテムを取り出すたびに、ユーザ情報ををDBから取り出さずに済む
      # 作成日時が新しいものが上に来るように並び替え
      
    end
  end
end

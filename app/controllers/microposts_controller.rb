class MicropostsController < ApplicationController
    # ApplicationControllerにあるlogged_in_userメソッドを実行し、
    # ログインしていない場合はcreateメソッドは実行しないで
    # /loginにリダイレクトするようにしています。
    before_action :logged_in_user, only: [:create]
    
    def create
        # パラメータを受け取って現在のユーザーに紐付いたMicropostの
        # インスタンスを作成して@micropost変数に入れ、
        # @micropost.saveで保存が成功した場合は、root_urlである/にリダイレクトを行い、
        # 失敗した場合はapp/views/static_pages/home.html.erbのテンプレートを表示します。
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Microposts created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
                # feed_items(user.rb（モデル）で定義)
                ## 現在のユーザのフォローしているユーザのマイクロポストを取得
                # includes(:user) : ユーザ情報をあらかじめ先読み（プリロード）する
                ## @feed_itemsからアイテムを取り出すたびに、ユーザ情報ををDBから取り出さずに済む
                # 作成日時が新しいものが上に来るように並び替え
            render 'static_pages/home'
        end
    end
    
    def destroy
        # 投稿が現在のユーザーのものでなければ、root_urlにリダイレクトするようにしています。
        # 投稿が現在のユーザーのものであれば、@micropost.destroy で削除し、
        # リダイレクトを行っています。
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end
    
    private
    # フォームから受け取ったパラメータのparams[:micropost]のうち、
    # params[:micropost][:content]のみデータの作成に使用するように
    # Strong Parametersを宣言しています。
    def micropost_params
        params.require(:micropost) .permit(:content)
    end
    
end

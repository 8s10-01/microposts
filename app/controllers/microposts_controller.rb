class MicropostsController < ApplicationController
    
    before_action :logged_in_user, only: [:create]
    
    def create
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
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end
    
    private
    def micropost_params
        params.require(:micropost) .permit(:content)
    end
    
end

class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }

    validates :name, presence: true, length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    has_secure_password
    has_many :microposts

# あるユーザーがフォローしている人の集まり
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
# あるユーザをフォーローしている人の集まり
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
# 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

# フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

# あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
# 自分とフォローしているユーザのつぶやきを取得するメソッド
  def feed_items
    Microposts.where(user_id: following_user_ids + [self.id])
    # following_user_ids:has_many :follwing_users(18行目)で自動的に生成されたメソッド
    # フォローしているユーザのIDを配列で返す。
    # 配列同士は、+ で要素を足し合わせることができる。
    
    # self.id:selfは、どのユーザがこのコードを実行しようとしているかで変わります。
    # user1.feed_itemsの場合、self=user1となります。
    
    # Microposts:モデル名
    # .where(user_id: ):select microposts.* from micropost where microposts.user_id = ???
  end
  
end

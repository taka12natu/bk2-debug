class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
  # validates :prefecture_code, presence: true
  # validates :city, presence: true
  # validates :street, presence: true

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

# 能動的関係（フォローしている）
  has_many :relationships, dependent: :destroy #foreign_key: 'user_id'
  has_many :followings, through: :relationships, source: :follow
# 受動的関係（フォローされている）
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def self.search(word,match)
    if match == "forward_match"
      @user = User.where(['name LIKE ?', "#{word}%"])
    elsif match == "backward_match"
      @user = User.where(['name LIKE ?', "%#{word}"])
    elsif match == "perfect_match"
      @user = User.where(['name = ?', "#{word}"])
    elsif match == "partial_match"
      @user = User.where(['name LIKE ?', "%#{word}%"])
    end
  end

  def address
    "%s %s %s"%([self.prefecture_code, self.city, self.street])
  end

  geocoded_by :address
  after_validation :geocode
end

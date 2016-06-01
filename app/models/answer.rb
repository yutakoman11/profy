class Answer < ActiveRecord::Base
   belongs_to :question
   belongs_to :user
   has_one :feed_content, as: :content, dependent: :destroy
   #callback
  after_create :create_feed_content
  after_update :update_feed_content

  #validation
  validates_presence_of :user_id, :text

  private
  def create_feed_content
    self.feed_content = FeedContent.create(group_id: question.group_id, updated_at: updated_at)
  end

  def update_feed_content
    self.feed_content.update(updated_at: updated_at)
  end
end
# :dependentオプションによる、親モデルと子モデルの依存関係は5種類ある。
# 1.親objectが削除されたとき、それに紐づく子objectが同時にdestroyされる
# => dependent: :destroy
# 2.親objectが削除されたとき、それに紐づく子objectがdatabaseから直接削除される。よって、コールバックは発生しない。
# => dependent: :delete_all
# 3.親objectが削除されたとき、それに紐づく子objectの外部キーをnullにする
# => dependent: :nullify
# 4. 親objectが削除されたとき、それに紐づく子objectがある場合、例外を発生させる
# =>dependent: :restrict_with_exception
# 5.親objectが削除されたとき、それに紐づく子objectがある場合、エラーを発生させる
# => dependent: :restrict_with_error
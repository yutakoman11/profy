class Question < ActiveRecord::Base
  #association
  belongs_to :user
  belongs_to :group
  has_many :answers, dependent: :destroy
  has_one :feed_content, as: :content, dependent: :destroy
  #callback
  after_create :create_feed_content


  #validation
  validates_presence_of :user_id, :text, :group_id

  def user_answer(user_id)
      Answer.find_by(user_id: user_id, question_id: id)
  end

  private
  def create_feed_content
    self.feed_content = FeedContent.create(group_id: group_id, updated_at: updated_at)
  end
end

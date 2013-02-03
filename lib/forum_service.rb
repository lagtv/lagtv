class ForumService
  def self.latest_topics
    Forem::Topic.joins("inner join forem_posts fp on (forem_topics.id = fp.topic_id)
                        inner join forem_forums ff on (ff.id = forem_topics.forum_id)")
        .where(:state => 'approved', :hidden => false)
        .where("fp.state = 'approved'")
        .where("ff.category_id <> ?", CONFIG[:support_category_id]) # Hide the support forum posts
        .group('forem_topics.id')
        .order("last_post_at desc")
        .limit(10)
        .select("forem_topics.*")
  end

  def self.latest_posts(page = 1)
    Forem::Post.where(:state => 'approved').order('updated_at desc').paginate(:page => page, :per_page => 25)
  end

  def self.page_post_appears_on(post)
    number_of_posts_before_this_one = Forem::Post
                                        .where(:state => 'approved', :topic_id => post.topic.id)
                                        .where('created_at < ?', post.created_at)
                                        .count
    posts_per_page = 20.0                                    

    page = ((number_of_posts_before_this_one + 1) / posts_per_page).ceil
  end

  def self.topics_started_by(user, page = 1)
    Forem::Topic.where(:user_id => user.id, :state => 'approved', :hidden => false).paginate(:page => page, :per_page => 25)
  end

  def self.topics_with_posts_by(user, page = 1)
    Forem::Topic.joins("inner join forem_posts fp on (forem_topics.id = fp.topic_id)")
        .where(:state => 'approved', :hidden => false)
        .where("fp.state = 'approved'")
        .where("fp.user_id = :user_id", :user_id => user.id)
        .where("forem_topics.user_id <> :user_id", :user_id => user.id)
        .group('forem_topics.id')
        .order("last_post_at desc")
        .select("forem_topics.*")
        .paginate(:page => page, :per_page => 25)
  end
end
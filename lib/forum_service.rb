class ForumService
  def self.latest_topics
    Forem::Topic.where(:state => 'approved', :hidden => false).order('updated_at desc').limit(10)
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
end
class ForumService
  def self.latest_topics
    # The Forem::Topic#last_post_at attribute isn't being updated when new posts are added to a topic, 
    # so need to craft a query based on created_at of posts
    Forem::Topic.joins("inner join forem_posts fp on (forem_topics.id = fp.topic_id)
                        inner join forem_forums ff on (ff.id = forem_topics.forum_id)")
        .where(:state => 'approved', :hidden => false)
        .where("fp.state = 'approved'")
        .where("ff.category_id <> ?", CONFIG[:support_category_id]) # Hide the support forum posts
        .group('forem_topics.id')
        .order("latest_post_at desc")
        .limit(10)
        .select("forem_topics.*, max(fp.created_at) as latest_post_at")

    # Should build this query:
      # select ft.* from forem_topics ft inner join forem_posts fp on (ft.id = fp.topic_id) 
      # inner join forem_forums ff on (ff.id = ft.forum_id)
      # where ft.state = 'approved' and ft.hidden = 'f' 
      # and fp.state = 'approved' 
      # and ff.category_id <> 3
      # group by ft.id 
      # order by max(fp.created_at) desc;
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
class ForumService
  def self.latest_topics
    # The Forem::Topic#last_post_at attribute isn't being updated when new posts are added to a topic, 
    # so need to craft a query based on updated_at of posts
    Forem::Topic.joins("inner join forem_posts fp on (forem_topics.id = fp.topic_id)")
        .where(:state => 'approved', :hidden => false)
        .where("fp.state = 'approved'")
        .group('forem_topics.id')
        .order("max(fp.updated_at) desc")
        .select("forem_topics.*")

    # Should build this query:
    #   select ft.* from forem_topics ft inner join forem_posts fp on (ft.id = fp.topic_id) 
    #   where ft.state = 'approved' and ft.hidden = 'f' 
    #   and fp.state = 'approved' 
    #   group by ft.id 
    #   order by max(fp.updated_at) desc;
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
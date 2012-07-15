class ForumService
  def self.latest_topics
    Forem::Topic.where(:state => 'approved', :hidden => false).order('last_post_at desc').limit(10)
  end
end
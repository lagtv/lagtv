class Gravatar
  def self.url(email, size = 100)
    gravitar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravitar_id}.png?s=#{size}&d=mm"
  end
end
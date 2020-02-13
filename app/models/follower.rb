class Follower
  attr_reader :name, :url, :github_id

  def initialize(info)
    @name = info[:name]
    @url = info[:url]
    @github_id = info[:id]
  end

  def exists_as_user?
    User.exists?(github_id: github_id)
  end
end

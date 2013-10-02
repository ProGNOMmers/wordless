class User::Options
  def initialize(user)
    @user = user
  end

  def [](key)
    user.meta
  end
end
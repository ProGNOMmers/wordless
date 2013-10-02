class User < ActiveRecord::Base

  ROLE_KEY = 'role'

  has_many :meta, class_name: 'Usermeta', dependent: :destroy

  # Roles
  has_many :roles, -> { where key: ROLE_KEY }, class_name: 'Usermeta', dependent: :destroy

  # In WordPress user options are user meta whose keys start with the blog 
  # name. It seems weird to me, so we use a column.
  # has_many :options, -> { where option: true }, class_name: 'Usermeta', dependent: :destroy

  has_secure_password

  # Support roles assignment using string arguments
  def roles_with_from_array_of_strings=(*roles)
    roles = roles.first if roles.size == 1 && roles.first.is_a?(Array)
    roles = roles.map{ |r| r.is_a?(Usermeta) ? r : Usermeta.find_or_initialize_by(user_id: id, key: ROLE_KEY, value: r) }
    self.roles_without_from_array_of_strings = *roles
  end
  alias_method_chain :roles=, :from_array_of_strings

  # Maybe better role?/has_role? in order to avoid confusion with is_a?
  # def is?(role)
  #   User.first.roles.where(value: role).exists?
  # end

  # def role=(role)
  #   self.roles = [ role.is_a?(Usermeta) ? role : Usermeta.find_or_initialize_by(user_id: id, key: ROLE_KEY, value: role) ]
  # end

end

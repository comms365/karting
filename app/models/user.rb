# model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :init

  def init
    self.roles_mask = 1 if new_record?
  end

  enum roles_mask: %i(admin user)

  default_scope { order(id: :asc) }

  def self.current_user=(usr)
    Thread.current[:current_user] = usr
  end

  def self.current_user
    Thread.current[:current_user]
  end

  # ROLES = %i[admin user]

  # def roles=(roles)
  #   roles = [*roles].map { |r| r.to_sym }
  #   self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  # end

  # def roles
  #   ROLES.reject do |r|
  #     ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
  #   end
  # end

  # def has_role?(role)
  #   roles.include?(role)
  # end

  # def admin?
  #   has_role?('admin')
  # end

  # def user?
  #   has_role?('user')
  # end
end

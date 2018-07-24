# model
require 'soft_deletion'

class Site < ActiveRecord::Base
  has_soft_deletion default_scope: true

  before_soft_delete :validate_deletability # soft_delete stops if this returns false
  after_soft_delete :send_deletion_emails

  has_many :user_site_sessions
end

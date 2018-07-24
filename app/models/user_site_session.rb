# model
class UserSiteSession < ActiveRecord::Base
  enum weather: %i(sunny rainy overcast)
  belongs_to :user
  belongs_to :site
  validate :session_date_cannot_be_in_the_future

  def session_date_cannot_be_in_the_future
    errors.add(:session_date, "can't be in the future") if session_date? && session_date > Time.Zone.today
  end

  scope :me, -> { where(user: User.current_user).order(lap_time: :ASC) }

  scope :all_quickest, -> { order(lap_time: :ASC) }

  def self.fetch_lap_times
    select(
      'user_site_sessions.*, users.name as user_name, sites.name as venue_name'
    ).joins(:user, :site)
  end
end

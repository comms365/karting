class UserSiteSession < ActiveRecord::Base
	enum weather: [:sunny,:rainy,:overcast]
	belongs_to :user
	belongs_to :site
	validate :expiration_date_cannot_be_in_the_future

	def expiration_date_cannot_be_in_the_future
    if session_date? && session_date > Date.today
      errors.add(:session_date, "can't be in the future")
    end
  end

  scope :find_by_user, lambda { |user|
    where(:user_id => user.id).order(lap_time: :ASC)
  }

  scope :find_by_all_quickest, -> { order(lap_time: :ASC) }

end

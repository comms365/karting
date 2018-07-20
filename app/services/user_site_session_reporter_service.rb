class UserSiteSessionReporterService

	def construct (params)
		return {
			"weather" => UserSiteSession.weathers[params[:weather]],
			"date_from" => params[:date_from],
			"date_to" => params[:date_to],
			"site_id" => params[:site_id],
		}
	end


	def build_query (params)
		if params['weather'].blank?
			res = UserSiteSession.select('user_site_sessions.*, users.name as user_name, sites.name as venue_name').joins(:user, :site).where({
					session_date: params['date_from']..params['date_to'], 
					site: params['site_id']
				}).find_by_all_quickest()
		else
			res = UserSiteSession.select('user_site_sessions.*, users.name as user_name, sites.name as venue_name').joins(:user, :site).where({ 
					session_date: params['date_from']..params['date_to'], 
					site: params['site_id'], 
					weather: params['weather'] 
				}).find_by_all_quickest()
		end
	end

end
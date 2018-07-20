class UserSiteSessionReporterService

	def construct (params)
		return {
			"weather" => UserSiteSession.weathers[params[:weather]],
			"date_from" => params[:date_from],
			"date_to" => params[:date_to],
			"site_id" => params[:site_id],
			"lap_time_from" => params[:lap_time_from],
			"lap_time_to" => params[:lap_time_to]
		}
	end


	def build_query (params)
		# core set of where conditions to match on
		where = {
			session_date: params['date_from']..params['date_to'], 
			site: params['site_id']
		}

		# if we have the selected weather include that in our where statement
		if(!params['weather'].blank?) 
			where = where.merge({
				weather: params['weather']
			})
		end

		# if we have a lap time range including from and to , then we will include them both in our where statement
		if (!params['lap_time_from'].blank? && !params['lap_time_to'].blank?)
			if(params['lap_time_from'].to_f && ( params['lap_time_to'].to_f && params['lap_time_to'].to_f != 0.0 ) ) 
				where = where.merge({
					lap_time: params['lap_time_from']..params['lap_time_to']
				})
			end
		end

		res = UserSiteSession.select('user_site_sessions.*, users.name as user_name, sites.name as venue_name').joins(
			:user, :site).where(where).find_by_all_quickest()
	end

end
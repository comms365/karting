# handles report query generation
class UserSiteSessionReporterService
  def initialize(params)
    @params = params.slice('date_from', 'date_to', 'site_id', 'lap_time_from', 'lap_time_to', 'weather')
    sanitize_params
  end

  def build_query
    @query = UserSiteSession.select('user_site_sessions.*, users.name as user_name, sites.name as venue_name')
                            .joins(:user, :site)
                            .where(session_date: @params['date_from']..@params['date_to'])
                            .where(site: @params['site_id'])
                            .all_quickest

    # if we have the selected weather include that in our where statement
    @query = @query.where(weather: @params['weather']) if @params['weather'].present?
    lap_time_query
    @query
  end

  private

    def sanitize_params
      @params['weather'] = UserSiteSession.weathers[@params['weather']]
      check_lap_times
    end

    def check_lap_times
      @params['lap_time_from'] = @params['lap_time_from'].to_f if @params['lap_time_from']
      @params['lap_time_to'] = @params['lap_time_to'].to_f if @params['lap_time_to']
      return unless @params['lap_time_to'] && @params['lap_time_to'].zero?
      @params.delete('lap_time_to')
      @params.delete('lap_time_from') if @params['lap_time_from']
    end

    def lap_time_query
      # if we have a lap time range including from and to , then we will include them both in our where statement
      return unless @params['lap_time_from'].present? && @params['lap_time_to'].present?
      @query = @query.where(lap_time: @params['lap_time_from']..@params['lap_time_to'])
    end
end

# controller
class SiteController < ApplicationController
  # site controller. handles report generation mostly.
  require 'date'

  private

    def find_last_day_of_month(my_date)
      if my_date.instance_of? String
        @end_of_the_month = (Date.parse(my_date).next_month - 1).to_s
      elsif _date.instance_of? Date
        @end_of_the_month = my_date.next_month.strftime('%Y-%m-01') - 1
      end
      @end_of_the_month
    end

    def index; end

    def report
      # @data = UserSiteSessionReporterService.new({})
      @sites = Site.all
    end

    def generate
      form_vals = params[:user_site_session]
      sanitize_inputs(formVals)
      @regex = '^(?:199[0-9]|20[0-9][0-9])-(?:0[1-9]|1[0-2])-(?:[0-2][0-9]|3[0-1])$'
      @decimal = "/(^(\d+)(\.)?(\d+)?)|(^(\d+)?(\.)(\d+))/"
      @service = UserSiteSessionReporterService.new(form_vals)
      @res = @service.build_query
      render 'generate', locals: { msg: @msg }
    end

  private

    def sanitize_inputs(form_vals)
      if form_vals['site_id'].blank?
        @msg = 'Please select a venue.'
      elsif form_vals['date_from'].match(@regex).nil?
        @msg = 'Date From is not valid. Please enter in YYYY-MM-DD format.'
      elsif form_vals['date_to'].blank?
        to = find_last_day_of_month(formVals['date_from'])
        form_vals['date_to'] = to
      elsif form_vals['date_to'].match(@regex).nil?
        @msg = 'Date To is not valid. Please enter in YYYY-MM-DD format.'
      end
      handle_deletion_of_keys(form_vals)
    end

  private

    def handle_deletion_of_keys(form_vals)
      if form_vals['lap_time_from'].present?
        form_vals.delete('lap_time_from') if !form_vals['lap_time_from'] =~ @decimal
        form_vals.delete('lap_time_to') if !form_vals['lap_time_from'] =~ @decimal
      end
      if form_vals['lap_time_to'].present?
        form_vals.delete('lap_time_from') if !form_vals['lap_time_to'] =~ @decimal
        form_vals.delete('lap_time_to') if !form_vals['lap_time_to'] =~ @decimal
      end
    end
end

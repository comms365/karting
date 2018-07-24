# controller
class SiteController < ApplicationController
  # site controller. handles report generation mostly.
  require 'date'
  
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
      @sites = Site.all
    end

    def generate
      @form_vals = params[:user_site_session]
      sanitize_inputs
      @service = UserSiteSessionReporterService.new(@form_vals)
      @res = @service.build_query
      render 'generate', locals: { msg: @msg }
    end

    def sanitize_inputs
      validate_params
      handle_deletion_of_keys
    end

    def handle_deletion_of_keys
      @decimal = "/(^(\d+)(\.)?(\d+)?)|(^(\d+)?(\.)(\d+))/"
      examine_lap_time_from(@form_vals) if @form_vals['lap_time_from'].present?
      examine_lap_time_to(@form_vals) if @form_vals['lap_time_to'].present?
    end

    def examine_lap_time_from
      @form_vals.delete('lap_time_from') unless @form_vals['lap_time_from'] =~ @decimal
      @form_vals.delete('lap_time_to') unless @form_vals['lap_time_from'] =~ @decimal
    end

    def examine_lap_time_to
      @form_vals.delete('lap_time_from') unless form_vals['lap_time_to'] =~ @decimal
      @form_vals.delete('lap_time_to') unless form_vals['lap_time_to'] =~ @decimal
    end

    def validate_params
      regex = '^(?:199[0-9]|20[0-9][0-9])-(?:0[1-9]|1[0-2])-(?:[0-2][0-9]|3[0-1])$'
      if @form_vals['site_id'].blank?
        @msg = 'Please select a venue.'
      elsif @form_vals['date_from'].match(regex).nil?
        @msg = 'Date From is not valid. Please enter in YYYY-MM-DD format.'
      elsif @form_vals['date_to'].blank?
        to = find_last_day_of_month(@form_vals['date_from'])
        @form_vals['date_to'] = to
      elsif @form_vals['date_to'].match(regex).nil?
        @msg = 'Date To is not valid. Please enter in YYYY-MM-DD format.'
      end
    end
end

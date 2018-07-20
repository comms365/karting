class SiteController < ApplicationController
require "date"

  def find_last_day_of_month(_date)
   if(_date.instance_of? String)
     @end_of_the_month =(Date.parse(_date).next_month-1).to_s
   elsif(_date.instance_of? Date)
     @end_of_the_month = _date.next_month.strftime("%Y-%m-01") - 1
   end
   return @end_of_the_month
  end

  def index
  end

  def report
  	@data = UserSiteSessionReporterService.new;
  	@sites = Site.select("id,name").all
  end

  def generate
    @service =  UserSiteSessionReporterService.new;
  	regex = "^(?:199[0-9]|20[0-9][0-9])-(?:0[1-9]|1[0-2])-(?:[0-2][0-9]|3[0-1])$";
  	formVals = params[:user_site_session]

    if(formVals['site_id'].blank?) 
      msg = 'Please select a venue.'
    elsif formVals['date_from'].match(regex) == nil
      msg = 'Date From is not valid. Please enter in YYYY-MM-DD format.'
    else

    if formVals['date_to'].blank?
          to = find_last_day_of_month(formVals['date_from'])
          formVals['date_to'] = to
    elsif formVals['date_to'].match(regex) == nil
          msg = 'Date To is not valid. Please enter in YYYY-MM-DD format.'
    end

  		@params = @service.construct(formVals)
  		@res =  @service.build_query(@params);
    end
      render "generate", locals: {msg: msg}
  end

end

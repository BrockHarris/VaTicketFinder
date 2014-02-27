class MainController < ApplicationController
	
	def home
		@results = Resultlog.order.all
		@pos_results = Resultlog.where(:status => false)
		@neg_results = Resultlog.where(:status => true)

		@double_pos_results = Resultlog.where(:tickets => '0')

		@fallbacks = @neg_results.count - @double_pos_results.count
		@last_update = Resultlog.order("created_at").first
		@latest_records = Resultlog.order.after(Time.now - 1.hours)
	end
end
class ResultlogsController < ApplicationController

	def create
    @resultlog = Resultlog.new(params[:resultlog])
		@resultlog.save
		redirect_to "#"
  end
  def destroy
  	@resultlogs = Resultlog.all  
  	@resultlogs.destroy
  end
end

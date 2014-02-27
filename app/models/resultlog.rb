class Resultlog < ActiveRecord::Base

	attr_accessible :event, :status, :tickets
	
	scope :order, order("resultlogs.created_at DESC")
end

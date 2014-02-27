namespace :check_availability do
  desc "Check For Tickets"
  task :loop_tickets => :environment do
  	require 'twilio-ruby'
  	require 'mechanize'

  	# For Twilio #
  	account_sid = 'some_sid'
		auth_token = 'some_token'
		# End #

		6.times do
  		agent = Mechanize.new
			agent.user_agent_alias = 'Mac Safari'

			page = agent.get('https://www.ticketreturn.com/UVA/SignIn.aspx')
			login_form = page.form_with(:id => "aspnetForm")

			username_field = login_form.field_with(:id => "ctl00_cphMain_Login1_UserName")
			password_field = login_form.field_with(:id => "ctl00_cphMain_Login1_Password")

			username_field.value = 'username'
			password_field.value = 'password'
		
			initial_page = login_form.click_button

			event_page = agent.click(initial_page.link_with(:href => /SelectEvent.aspx/))

			ticket_page = agent.click(event_page.link_with(:href => "SelectEvent.aspx?Link=SelectEvent.aspx&EventID=xxx"))

			result = ticket_page.parser.css('.MainAreaLogo').text.include? 'There are no more tickets available.'
		
			if result
				@tickets = "0"
				@comment = ticket_page.title
			else
				@tickets = "1"
				@comment = ticket_page.title

				@client = Twilio::REST::Client.new account_sid, auth_token
				message = @client.account.sms.messages.create(:body => "Tickets Found!",
    		:to => "+11111111111", :from => "+11111111111")
	      puts message.sid
			end
    
    	Resultlog.create!(:event => @comment, :status => result, :tickets => @tickets )

    	sleep 2
    end
  end
end

set :output, "/Users/Brock/UVAtickets/log/cron_log.log"

set :environment, 'development'

every 1.minute do
  rake "check_availability:loop_tickets"
end

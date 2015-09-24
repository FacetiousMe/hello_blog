class WelcomeController < ApplicationController
  def index
  	logMe("show")
  end

  private
  	def logMe(msg)
			@tag = "WelcomeController"
			logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
			logger.tagged(@tag){ logger.info msg }
	end
end

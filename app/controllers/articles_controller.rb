class ArticlesController < ApplicationController
# Convention Order: index, show, new, edit, create, update and destroy.
# These public methods should be defined before private/protected methods.
	
	def index
		logMe("index")

		# articles#index via GET
		@articles = Article.all
	end
	
	def show
		logMe("show")

		# Using find() to find the desired Article with :id from the Request.
		# Hold a reference to Article with @article.
		@article = Article.find(params[:id])
	end

	def new
		logMe("new")
		@article = Article.new
	end
	
	def edit
		logMe("edit")
		@article = Article.find(params[:id])
	end
	
	def create
		logMe("create")

		# Form field ":article" is passed into Rails, then referenced by the Controller.

		# The params method returns an ActiveSupport::HashWithIndifferentAccess object, 
		# which allows you to access the keys of the hash using either strings or symbols. 
		# In this situation, the only parameters that matter are the ones from the form.
		#render plain: params[:article].inspect
		
		
		# Example of "strong parameters" and "requires us to tell Rails exactly 
		# which parameters are allowed into our controller actions"
		#@article = Article.new(params.require(:article).permit(:title, :text))
		
		
		@article = Article.new(article_params)
		# Check if the Article saved successfully by passing Article validation.
		if @article.save
			# Send an HTTP redirect status code
			redirect_to @article
		else
			# Create a full response to send back
			render 'new'
		end
	end
	
	def update
		logMe("update")
		@article = Article.find(params[:id])
		
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		logMe("destroy")
		# logMe(params.inspect)
		# raise params.inspect

		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end

	private
		def article_params
			params.require(:article).permit(:title, :text)
		end

		def logMe(msg)
			@tag = "ArticlesController"
			logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
			logger.tagged(@tag){ logger.info msg }
		end
end

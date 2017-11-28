class DailyMotivationsController < ApplicationController
	before_action :set_daily_motivation, only: [:show, :update, :destroy]

	# GET /daily_motivations
	def index
		@daily_motivations = DailyMotivation.all
		json_response(@daily_motivations)
	end

	# POST /daily_motivations
	def create
		@daily_motivation = DailyMotivation.create!(daily_motivation_params)
		json_response(@daily_motivation, :created)
	end

	# GET /daily_motivations/:id
	def show
		json_response(@daily_motivation)
	end

	# PUT /daily_motivations/:id
	def update
		@daily_motivation.update(daily_motivation_params)
		head :no_content
	end

	# DELETE /daily_motivations/:id
	def destroy
		@daily_motivation.destroy
		head :no_content
	end

	private

	def daily_motivation_params
		# whitelist params
		params.permit(:quote, :author)
	end

	def set_daily_motivation
		@daily_motivation = DailyMotivation.find(params[:id])
	end
end

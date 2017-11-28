class DailyMotivation < ApplicationRecord
	# validations
	validates_presence_of :quote, :author
end

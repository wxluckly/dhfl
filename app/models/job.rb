class Job < ActiveRecord::Base
	default_scope -> { where(is_valid: true).order('jobs.position') }
	scope :before, -> (position) { where("position < ?", position) }
end

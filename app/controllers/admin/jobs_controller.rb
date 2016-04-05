class Admin::JobsController < Admin::BaseController
	before_action :set_job, only: [:edit, :update, :destroy]
	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

	def create
		@job = Job.new(job_params)
		if @job.save
			flash[:alert] = '添加成功'
			redirect_to admin_jobs_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if params[:type] == 'reorder'
	    unless @job.position == Job.minimum(:position)
	      last_shop = Job.before(@job.position).last
	      last_position = last_shop.position
	      last_shop.update_attribute(:position, @job.position)
	      @job.update_attribute(:position, last_position)
	    end
	    redirect_to admin_jobs_path
    else
			if @job.update(job_params)
				redirect_to admin_jobs_path
			else
				render 'edit'
			end
		end
	end

	def destroy
		if @job.destroy
			flash[:alert] = '删除成功'
			redirect_to admin_jobs_path
		else
			flash[:alert] = '删除失败'
			redirect_to :back
		end
	end

	private

	def set_job
		@job = Job.find(params[:id])
	end

	def job_params
		params.require(:job).permit(:name, :content, :position, :is_valid)
	end

end

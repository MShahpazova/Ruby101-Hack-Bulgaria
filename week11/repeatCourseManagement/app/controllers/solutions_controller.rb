class SolutionsController < ApplicationController
  before_action :set_lecture
  before_action :set_task

  def index
    @solutions = Solution.all  
  end

  def new
    @solution = Solution.new
  end

  def show
    @solution = @task.solutions.find(params[:id])  
  end
  
  def create
   @solution = @task.solutions.build(solution_params)
   if @solution.save
    redirect_to lecture_task_solutions_path(@lecture, @task)
   else
    render :new
   end 
  end
  
  def destroy
    @solution.destroy
  end

  def edit
    @solution = Solution.find(params[:id])
  end
  
  def update 
    @solution.update(solution_params)
    if @solution.update
        redirect to lecture_task_solutions(@lecture, @task)
    else
      render :edit
    end    
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def solution_params
    params.require(:solution).permit(:content)
  end
end
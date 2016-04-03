class SolutionsController < ApplicationController
  before_action :set_lecture

  def index
    @solutions = task.solutions  
  end

  def show
    @solution = task.solutions.find(params[:id])
  end

  def new
    @solution = Solution.new
  end

  def create
    # @task = @lecture.tasks.create(task_params)
    # solution_params.delete(task_id)
    @solution = task.solutions.create(solution_params)
    # @solution = @task.solutions.create(Solution.new(solution_params)) 
    # forgotten @
    if @solution.valid?(@solution)
      # forgotten _path
      redirect_to lecture_task_solutions_path(lecture, task)
    else  
      render :new, status: :unprocessable_entity
    end
  end

  
  private

  def task
    @task ||= Task.find(params[:task_id])
  end
  helper_method :task

  def lecture
    @lecture = Lecture.find(params[:lecture_id])
  end
  helper_method :task

  def solution_params
    # params.require(:task).permit(:name, :description)
    params.require(:solution).permit(:content)
  end
end

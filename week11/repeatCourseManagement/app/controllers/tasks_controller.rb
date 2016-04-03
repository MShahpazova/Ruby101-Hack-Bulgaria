class TasksController < ApplicationController
  before_action :set_lecture

  def index
    @tasks = @lecture.tasks
  end

  def show
    @task = @lecture.tasks.find(params[:id])  
  end
  
  def new
    @task = Task.new
  end
  

  def create
    @task = @lecture.tasks.build(task_params)
    if @task.save
      redirect_to lecture_tasks_path(@lecture)
    else
      render :new
    end
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end

  def task_params
    params.require(:task).permit(:name, :content)
  end
end
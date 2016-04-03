class TasksController < ApplicationController
  before_action :set_lecture

  def index
    @tasks = @lecture.tasks
  end

  def show
    @task = @lecture.tasks.find([:id])
  end

  def new
   @task = Task.new  
  end

  def edit
   @task = @lecture.tasks.find(params[:id])  
  end
  
  def update
    @task = @lecture.tasks.find(params[:id])
    @task.update(task_params)
     if @task.valid?(@task)
      redirect_to lecture_tasks_path(params[:lecture_id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  
  def create
    debugger
    @task = @lecture.tasks.create(task_params)
    if @task.valid?(@task)
      redirect_to lecture_tasks_path(params[:lecture_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end
  
  def task_params
    params.require(:task).permit(:name, :description)
  end
end

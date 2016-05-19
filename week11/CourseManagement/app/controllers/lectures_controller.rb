class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def show
    @lecture = Lecture.find(params[:id]) 
  end
  
  def edit
    @lecture = Lecture.find(params[:id]) 
  end

  def new
    @lecture = Lecture.new    
  end

  def create
    @lecture = Lecture.new(lecture_params)
    if @lecture.save
      redirect_to lectures_path 
    else    
      render :new
    end
  end

  def update
    @lecture = Lecture.find(params[:id])
    if @lecture.update(lecture_params)
      redirect_to @lecture
    else
      render :edit
    end
  end

  def destroy
    @product = Lecture.find(params[:id])
    @product.destroy
    if @product.destroyed?
        redirect_to action: "index"
    else
        render @product.errors
    end  
  end

  private 
  def lecture_params
      params.require(:lecture).permit(:name, :text_body)
  end
end

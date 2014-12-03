class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end 
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      redirect_to @task, :notice => "Success!"
    else
      render 'edit'
    end    
  end

  def destroy
    Task.destroy params[:id]
    redirect_to :back, :notice => "Task has been deleted."
  end

  private
  def task_params
    params.require(:task).permit(:task, :due)
  end

end

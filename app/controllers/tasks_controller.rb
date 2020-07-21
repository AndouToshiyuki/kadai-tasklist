class TasksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc)
    end
  end

  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def new
    @task = Task.new
    #@task = current_user.tasks.find_by(id: params[:id])
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に作成されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task が作成されませんでした'
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
    
    if @task == nil
    redirect_to root_url
    end
    
  end

  def update
  @task = current_user.tasks.find_by(id: params[:id])
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end

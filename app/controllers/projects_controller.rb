class ProjectsController < ApplicationController
  before_action :require_login
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects.order(created_at: :desc)
  end

  def show
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    
    if @project.save
      flash[:notice] = "Project created successfully!"
      redirect_to @project
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project updated successfully!"
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project deleted successfully!"
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def ensure_owner
    unless @project.user == current_user
      flash[:alert] = "You can only access your own projects"
      redirect_to projects_path
    end
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end
end

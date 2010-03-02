class Admin::NodesController < ApplicationController
  
  layout 'admin'
  
  def index
    @nodes = Node.root.descendants.paginate( 
      :include => [:head, :draft],
      :page => params[:page], 
      :per_page => 25,
      :order => 'id DESC'
    )
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

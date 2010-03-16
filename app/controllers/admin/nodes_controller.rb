class Admin::NodesController < ApplicationController
  
  layout 'admin'
  
  before_filter :find_node, :only => [
                              :show,
                              :edit,
                              :update,
                              :destroy,
                              :publish,
                              :unlock
                            ]
  
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
  
  def show
    @node = Node.find(params[:id])
    @page = @node.draft || @node.head
  end

  def edit
    begin
      @draft = @node.find_or_create_draft( current_user )
    rescue LockedByAnotherUser => e
      flash[:error] = e.message
      if request.referer
        redirect_to :back
      else
        redirect_to node_path(@node)
      end
    end
  end

  def update
  end

  def destroy
  end
  
  private
  
    def find_node
      @node = Node.find(params[:id])
    end

end

# TODO find a common place for that
class LockedByAnotherUser < StandardError; end
class Node < ActiveRecord::Base
  
  # Mixins and Plugins
  acts_as_nested_set
  
  # Associations
  has_many    :pages, :order => "revision ASC"
  belongs_to  :head,  :class_name => "Page",  :foreign_key => :head_id
  belongs_to  :draft, :class_name => "Page",  :foreign_key => :draft_id
  
  # Class methods
  
  # Returns a page for a given node. If no revision is supplied, it returns
  # the last / current one. If a specific revision number is supplied, the 
  # corresponding revision of that page is returned. Get the current / latest 
  # revision with -1. It raises an Argument error if the revision is not a 
  # Fixnum
  def self.find_page path, revision = -1
    unless revision.class == Fixnum
      raise ArgumentError, "revision must be a Fixnum" 
    end

    node = Node.where(:unique_name => path).first

    if node
      case revision
      when -1        
        return node.head
      else
        return node.pages.find_by_revision( revision )
      end
    end
    
    nil
  end
end

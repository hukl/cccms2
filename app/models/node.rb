class Node < ActiveRecord::Base
  
  # Mixins and Plugins
  acts_as_nested_set
  
  # Associations
  has_many    :pages, :order => "revision ASC"
  belongs_to  :head,  :class_name => "Page",  :foreign_key => :head_id
  belongs_to  :draft, :class_name => "Page",  :foreign_key => :draft_id
  belongs_to  :lock_owner, :class_name => "User", :foreign_key => :locking_user_id
  
  
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
  
  # Instance Methods
  
  def find_or_create_draft current_user
    if draft && self.lock_owner == current_user
      draft
    elsif draft && self.lock_owner.nil?
      lock_for! current_user
      draft.user    = current_user if draft.user.nil?
      draft.editor  = current_user
      draft.save
      draft
    elsif draft && self.lock_owner != current_user
      raise(
        LockedByAnotherUser,
        "Page is locked by another user who is working on it! " \
        "Last modification: #{draft.updated_at.to_s(:db)}"
      )
    else
      lock_for! current_user
      create_new_draft current_user
    end
  end
  
  def create_new_draft user
    empty_page        = self.pages.create!
    empty_page.user   = (self.head ? self.head.user : user)
    empty_page.editor = user
    empty_page.save
    
    empty_page.clone_attributes_from self.head
    
    self.draft = empty_page
    self.save
    self.draft.reload
  end
  
  def unique_path
    unique_name.split("/") rescue [unique_name]
  end
  
  def locked?
    !self.lock_owner.nil?
  end
  
  protected
    def lock_for! current_user
      self.lock_owner = current_user
      self.save
    end
end

class LockedByAnotherUser < StandardError; end
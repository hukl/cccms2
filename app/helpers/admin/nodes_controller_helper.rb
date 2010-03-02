module Admin::NodesControllerHelper
  def title_for_node node
    if node.head
      node.head.title
    else
      node.draft.title
    end
  end
end

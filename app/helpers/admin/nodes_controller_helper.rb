module Admin::NodesControllerHelper
  def title_for_node node
    if node.head
      node.head.title
    else
      node.draft.title
    end
  end
  
  def custom_page_templates
    Page.custom_templates.map {|x| [x.gsub("_", " ").titlecase, x]}
  end
  
  def user_list
    User.all.map {|u| [u.login, u.id]}
  end
end

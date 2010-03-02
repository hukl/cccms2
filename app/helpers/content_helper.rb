module ContentHelper
  
  def headline_image
    
  end
  
  def main_menu
    menu_items = MenuItem.order("position ASC").all
    render(
      :partial => 'content/main_navigation', 
      :locals => {:menu_items => menu_items}
    )
  end
  
  def aggregate? content
    RedCloth.new(content).to_html.html_safe if content
  end
  
  def link_to_path title, path, html_options = {}
    if params[:page_path]
      active = params[:page_path] == path
    end
    
    active_class = active ? {:class => 'active'} : {:class => 'inactive'}
    
    html_options = html_options.merge(active_class)
    
    link_to title, content_path(path.split("/")), html_options
  end
end

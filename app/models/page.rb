class Page < ActiveRecord::Base
  
  PUBLIC_TEMPLATE_PATH = File.join(%w(custom page_templates public))
  FULL_PUBLIC_TEMPLATE_PATH = Rails.root.join('app', 'views', PUBLIC_TEMPLATE_PATH)
  
  # Globalize2
  translates :title, :abstract, :body
  
  # Associations
  belongs_to :node
  
  def public?
    published_at.nil? ? true : published_at < Time.now
  end
  
  def public_template_path
    File.join(PUBLIC_TEMPLATE_PATH, template_name)
  end
  
  def full_public_template_path
    File.join(FULL_PUBLIC_TEMPLATE_PATH, template_name)
  end
  
  def template_exists?
    File.exists? "#{full_public_template_path}.html.erb"
  end
  
  def template
    if template_name && template_exists?
      public_template_path
    else
      File.join(PUBLIC_TEMPLATE_PATH, 'standard_template')
    end    
  end
end

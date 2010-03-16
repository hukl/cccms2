class Page < ActiveRecord::Base
  
  PUBLIC_TEMPLATE_PATH = File.join(%w(custom page_templates public))
  FULL_PUBLIC_TEMPLATE_PATH = Rails.root.join('app', 'views', PUBLIC_TEMPLATE_PATH)
  
  # Globalize2
  translates :title, :abstract, :body
  
  # Associations
  belongs_to :node
  belongs_to :user
  belongs_to :editor, :class_name => "User"
  
  # Class Methods
  
  def self.custom_templates
    files = Dir.entries(FULL_PUBLIC_TEMPLATE_PATH).select do |x|
      x if x.gsub!(".html.erb", "")
    end
  end
  
  # Instance Methods
  
  def clone_attributes_from page
    return nil unless page
    
    self.reload
    
    # Clone untranslated attributes
    self.tag_list         = page.tag_list
    self.template_name  ||= page.template_name
    self.published_at     = page.published_at
    
    # Getting rid of the auto-generated empty translations
    self.translations.delete_all
    
    # Clone translated attributes
    page.translations.each do |translation|
      self.translations.create!(translation.attributes)
    end
    
    # Clone asset references
    self.assets = page.assets
    
    self.save
  end
  
  def tag_list
    "TODO implement tagging"
  end
  
  def tag_list= taglist = []
    "TODO implement tagging"
  end
  
  def assets
    "TODO implement assets"
  end
  
  def assets= assets = []
    "TODO implement assets"
  end
  
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

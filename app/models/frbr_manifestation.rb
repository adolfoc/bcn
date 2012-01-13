class FrbrManifestation < ActiveRecord::Base
  belongs_to :frbr_expression
  has_many :ots
  has_attached_file :document

  validates_attachment_presence :document

  def name
    frbr_expression.name
  end

  def as_text
    File.open("#{Rails.root.to_s}/public/system/documents/#{id.to_s}/original/#{document_file_name}", 'r') { |f| f.read }
  end

  def update_contents(contents)
    filename = "#{Rails.root.to_s}/public/system/documents/#{id.to_s}/original/#{document_file_name}"
    File.open(filename, 'w') { |f| f.write(contents) }
  end
end

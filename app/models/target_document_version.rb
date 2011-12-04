class TargetDocumentVersion < ActiveRecord::Base
  belongs_to :ot
  belongs_to :user
  belongs_to :markup_tool

  def self.next_version_for_ot(ot_id)
    last = where("ot_id = #{ot_id}").order("created_at ASC").last
    return "1.0" if last.nil?

    cv = last.version.to_f
    cv += 0.1
    cv.to_s
  end
end

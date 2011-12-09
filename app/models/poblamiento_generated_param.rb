class PoblamientoGeneratedParam < ActiveRecord::Base
  belongs_to :ot

  def self.earliest_legislature(ot_id)
    earliest = 0

    where("ot_id = #{ot_id}").each do |r|
      earliest = r.legislature if earliest == 0 || earliest > r.legislature
    end
    earliest
  end

  def self.latest_legislature(ot_id)
    latest = 0

    where("ot_id = #{ot_id}").each do |r|
      latest = r.legislature if latest == 0 || latest < r.legislature
    end
    latest
  end

  def self.earliest_session(ot_id)
    earliest = 0

    where("ot_id = #{ot_id}").each do |r|
      earliest = r.session if earliest == 0 || earliest > r.session
    end
    earliest
  end

  def self.latest_session(ot_id)
    latest = 0

    where("ot_id = #{ot_id}").each do |r|
      latest = r.session if latest == 0 || latest < r.session
    end
    latest
  end

  def self.total_processing(ot_id)
    where("ot_id = #{ot_id}").count
  end

  def self.number_no_processing(ot_id)
    count = 0

    where("ot_id = #{ot_id}").each do |r|
      count += 1 if r.processing == "Ninguno"
    end
    count
  end

  def self.number_partial(ot_id)
    count = 0

    where("ot_id = #{ot_id}").each do |r|
      count += 1 if r.processing == "Parcial"
    end
    count
  end

  def self.number_complete(ot_id)
    count = 0

    where("ot_id = #{ot_id}").each do |r|
      count += 1 if r.processing == "Completo"
    end
    count
  end

end

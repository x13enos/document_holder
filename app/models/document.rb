class Document < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  belongs_to :box, optional: true
  has_and_belongs_to_many :tags

  def self.search(params)
    select_by_name(params[:name]).
      select_by_box(params[:box_id]).
      select_by_tag(params[:tag_id]).
      select_by_date(params[:date])
  end

  private

  def self.select_by_name(value)
    value.present? ? where('name LIKE ?', "%#{value}%") : all
  end

  def self.select_by_box(value)
    value.present? ? where(box_id: value) : all
  end

  def self.select_by_tag(value)
    value.present? ? joins(:tags).where("tags.id = #{value}") : all
  end

  def self.select_by_date(value)
    if value.present?
      date = Date.parse(value)
      where("created_at BETWEEN ? and ?", date.beginning_of_day, date.end_of_day)
    else 
      all
    end
  end
end

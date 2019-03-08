class Article < ApplicationRecord
  validates :title, presence: true, allow_blank: false, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, allow_blank: false, length: { minimum: 100, maximum: 150000 }

  belongs_to :user
  belongs_to :category

  before_create :set_reading_time

  scope :visible, -> { where(is_draft: false) }
  scope :drafts, -> { where(is_draft: true) }


  private
  def set_reading_time
    # in WPM ( words per minute )
    avg_reading_time = 200

    unsanitized_text = self.body
    sanitized_text = Nokogiri::HTML(unsanitized_text)
    sanitized_text.css("style, script").remove
    sanitized_text = sanitized_text.text
    words_in_article = sanitized_text.split.size
    reading_time_in_mins = words_in_article / avg_reading_time

    if reading_time_in_mins < 1
      reading_time_in_mins = 1
    end

    self.reading_time_in_mins = reading_time_in_mins
  end
end

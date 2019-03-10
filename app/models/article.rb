class Article < ApplicationRecord
  has_attached_file :image, styles: { thumbnail: "300x200>", background_img: "1500x800>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  MIN_IMG_WIDTH = 1000
  MIN_IMG_HEIGHT = 600
  validates :title, presence: true, allow_blank: false, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, allow_blank: false, length: { minimum: 100, maximum: 150000 }
  validate :check_dimensions

  has_many :ratings
  belongs_to :user
  belongs_to :category

  before_create :set_reading_time

  scope :visible, -> { where(is_draft: false) }
  scope :drafts, -> { where(is_draft: true) }

  delegate :name, :slug_name, to: :category, prefix: true

  def rating_updated
    rating = Rating.where(article_id: self.id).average(:article_rating)
    self.avg_rating = rating
    self.save
  end

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

  def check_dimensions
    temp_file = image.queued_for_write[:original]
    unless temp_file.nil?
      dimensions = Paperclip::Geometry.from_file(temp_file)
      width = dimensions.width
      height = dimensions.height
      
      if width < MIN_IMG_WIDTH && height < MIN_IMG_HEIGHT
        errors.add(:image, "dimensions are too small. Minimum width: 1000px, minimum height: 600px")
      end
    end
  end

end

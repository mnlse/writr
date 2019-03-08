module FrontPageHelper

  # Prepares titles for front page
  def title_for_fp(art_title)
    max_length = 75
    art_title.length > max_length ? art_title[0..max_length] + "..." : art_title
  end
end

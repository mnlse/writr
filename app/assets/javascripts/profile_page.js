$(document).ready(function() {
  var profileArticles = $('.profile-articles'),
      loadMoreBtn = $('.profile-load-more-btn')
      lastArticleId = $('.prof-post').last().data("id");

  if(profileArticles.length > 0) {
    loadMoreBtn.click(function(event) {

      event.preventDefault();

      $.ajax({
        url: '/api/v1/articles/provide_profile_page_articles_as_html',
        data: {
          start_index: lastArticleId - 10,
          end_index: lastArticleId - 1
        },
        async: false,
        success: function(htmlData) {
          console.log(htmlData);
          $(htmlData).insertBefore('.profile-load-more-btn');
          lastArticleId = $('.prof-post').last().data("id");
        }
      });
    });
  }
});

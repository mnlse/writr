$(document).ready(function() {
  var el = {
    fpPostsCol: $('.fp__posts-col'),
    fp: $('.fp'),
    browseByCat: $('.browse-by-cat'),
    bbcPostsCol: $('.bbc__posts-col')
  }

  if(el.fp.length > 0) {
    var lastArticleId = $('.post').last().data("id");

    $(window).scroll(function(e) {
      // console.log("Window offset: " + $(window).scrollTop() + " Window height: " + $(window).height() + " Document height: " + $(document).height());
      if($(window).scrollTop() + $(window).height() >= ($(document).height() - 900)) {

        $.ajax({
          url: '/api/v1/articles/provide_articles_as_html',
          data: {
            start_index: lastArticleId - 7,
            end_index: lastArticleId - 1
          },
          async: false,
          success: function(htmlData) {
            el.fpPostsCol.append(htmlData);
            lastArticleId = $('.post').last().data("id");
          }
        });

      }
    });

  } else if(el.browseByCat.length > 0) {
    var lastArticleId = $('.post').last().data("id");

    $(window).scroll(function(e) {
      // console.log("Window offset: " + $(window).scrollTop() + " Window height: " + $(window).height() + " Document height: " + $(document).height());
      if($(window).scrollTop() + $(window).height() >= ($(document).height() - 900)) {

        $.ajax({
          url: '/api/v1/articles/provide_articles_as_html',
          data: {
            start_index: lastArticleId - 7,
            end_index: lastArticleId - 1
          },
          async: false,
          success: function(htmlData) {
            el.bbcPostsCol.append(htmlData);
            lastArticleId = $('.post').last().data("id");
          }
        });

      }
    });

  }
});

$(document).ready(function() {
  if ($('.pop-now-wgt').length) {
    let apiUrl = '/api/v1/widgets/popular_articles_in_timeframe';
    let animationTime = 500

    let clss = {
      timeBtnsActive: 'time-btns-active'
    };

    let sel = {
      timeBtnsCont: '.pop-now-wgt__time-btns',
      thisDayBtn: '.pop-now-wgt__this-day-btn',
      thisMonthBtn: '.pop-now-wgt__this-month-btn',
      thisYearBtn: '.pop-now-wgt__this-year-btn',
      timeBtns: '.pop-now-wgt__time-btn',
      body: '.pop-now-wgt__body',
      animatedBorder: '.pop-now-wgt__animated-border',
      timeBtnsActive: '.time-btns-active',
      loadMoreBtn: '.pop-now-wgt__load-more-btn',
      posts: '.pop-now-wgt__body .widget-post',
    };

    var init = (function() {
      var el = document.querySelector(sel.timeBtnsActive);
      moveAnimatedBorder(el, false);
    })();

    let evtListeners = {
      timeBtnsListener() {
        $(sel.timeBtns).click(function(evt) {
          $(sel.body).stop();

          evt.preventDefault();
          evt.stopPropagation();

          let $el = $(evt.target);
          let scope = $el.attr('data-scope');

          console.log($el);
          $(sel.timeBtns).removeClass(clss.timeBtnsActive);
          $el.addClass(clss.timeBtnsActive);
          moveAnimatedBorder(evt.target);

          if(scope === 'day') {
            $.ajax({
              url: apiUrl,
              data: {
                timeframe: 'day'
              },
              success: (html) => {
                console.log(html)

                $(sel.body).animate({
                  opacity: 0
                }, animationTime, () => {
                  $(sel.body).html('');
                  $(sel.body).append(html);
                });

                $(sel.body).animate({
                  opacity: 1
                }, animationTime)
              }
            });
          } else if(scope === 'week') {
            $.ajax({
              url: apiUrl,
              data: {
                timeframe: 'week'
              },
              success: (html) => {
                $(sel.body).animate({
                  opacity: 0
                }, animationTime, () => {
                  $(sel.body).html('');
                  $(sel.body).append(html);
                });

                $(sel.body).animate({
                  opacity: 1
                }, animationTime)
              }
            });
          } else if(scope === 'month') {
            $.ajax({
              url: apiUrl,
              data: {
                timeframe: 'month'
              },
              success: (html) => {
                $(sel.body).animate({
                  opacity: 0
                }, animationTime, () => {
                  $(sel.body).html('');
                  $(sel.body).append(html);
                });

                $(sel.body).animate({
                  opacity: 1
                }, animationTime)
              }
            });

          } else if(scope === 'year') {
            $.ajax({
              url: apiUrl,
              data: {
                timeframe: 'year'
              },
              success: (html) => {
                $(sel.body).animate({
                  opacity: 0
                }, animationTime, 
                function() {
                  $(sel.body).html('');
                  $(sel.body).append(html);

                  $(sel.body).animate({
                    opacity: 1
                  }, 1000)
                });

              }
            });
          } else {
            console.log("Error: Scope is wrong.");
          }

        })
      },

      loadMoreListener() {
        $(sel.loadMoreBtn).click(function(evt) {
          evt.preventDefault();
          evt.stopPropagation();

          let amount_displayed = $(sel.posts).length;
          let timeframe = $(sel.timeBtnsActive).attr('data-scope');

          $.ajax({
            url: '/api/v1/widgets/popular_articles_load_more',
            data: {
              amount: 3,
              amount_displayed: amount_displayed,
              timeframe: timeframe,
            },
            success: function(html) {
              $(sel.body).append(html);
              console.log(html);
            }
          })
        })
      }
    }

    evtListeners.timeBtnsListener();
    evtListeners.loadMoreListener();

    function moveAnimatedBorder(el, isAnimated = true) {
      if(el === null) return 0;
      let $el = $(el);

      if(isAnimated) {
        $(sel.animatedBorder).animate({
          left: `${$el.position().left}px`,
          width: `${$el.outerWidth()}px`
        }, animationTime, "easeInCubic");

      } else {
        $(sel.animatedBorder).css({
          left: `${$el.position().left}px`,
          width: `${$el.outerWidth()}px`
        });
      }
    }
  }
});

$(document).ready(function() {
  if ($('.top-rated-wgt').length) {
    let apiUrl = '/api/v1/widgets/top_articles_in_timeframe';
    let animationTime = 500

    let clss = {
      timeBtnsActive: 'time-btns-active'
    };

    let sel = {
      timeBtnsCont: '.top-rated-wgt__time-btns',
      thisDayBtn: '.top-rated-wgt__this-day-btn',
      thisMonthBtn: '.top-rated-wgt__this-month-btn',
      thisYearBtn: '.top-rated-wgt__this-year-btn',
      timeBtns: '.top-rated-wgt__time-btn',
      body: '.top-rated-wgt__body',
      animatedBorder: '.top-rated-wgt__animated-border',
      loadMoreBtn: '.top-rated-wgt__down-btn',
      timeBtnsActive: '.time-btns-active'
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
      loadMoreBtnListener() {
        $(sel.loadMoreBtn).click(function(evt) {
          evt.preventDefault();
          evt.stopPropagation();

          console.log('test');
        });
      }
    }

    evtListeners.timeBtnsListener();
    evtListeners.loadMoreBtnListener();

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

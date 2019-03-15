let clss = {
  timeBtnsActive: 'time-btns-active'
};

let sel = {
  timeBtnsCont: '.pop-now-wgt__time-btns',
  thisDayBtn: '.pop-now-wgt__this-day-btn',
  thisMonthBtn: '.pop-now-wgt__this-month-btn',
  thisYearBtn: '.pop-now-wgt__this-year-btn',
  timeBtns: '.pop-now-wgt__time-btn',
  body: '.pop-now-wgt__body'
};

let evtListeners = {
  timeBtnsListener() {
    $(sel.timeBtns).click(function(evt) {
      evt.preventDefault();
      evt.stopPropagation();

      let $el = $(evt.target);
      let scope = $el.attr('data-scope');
      let apiUrl = '/api/v1/widgets/popular_articles_in_timeframe';

      console.log($el);
      $(sel.timeBtns).removeClass(clss.timeBtnsActive);
      $el.addClass(clss.timeBtnsActive);

      $(sel.body).html('');

      if(scope === 'day') {
        $.ajax({
          url: apiUrl,
          data: {
            timeframe: 'day'
          },
          success: (html) => {
            console.log(html)
            $(sel.body).append(html);
          }
        });
      } else if(scope === 'month') {
        $.ajax({
          url: apiUrl,
          data: {
            timeframe: 'month'
          },
          success: (html) => {
            console.log(html)
            $(sel.body).append(html);
          }
        });

      } else if(scope === 'year') {
        $.ajax({
          url: apiUrl,
          data: {
            timeframe: 'year'
          },
          success: (html) => {
            console.log(html)
            $(sel.body).append(html);
          }
        });
      } else {

      }

    })
  }
}

evtListeners.timeBtnsListener();


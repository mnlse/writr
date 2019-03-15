$(document).ready(function() {
  var sel = {
    bdPost: '.bd-post',
    checkbox: '.bd-post__checkbox-input',
    bdPostTitle: '.bd-post__title',
    bdPostsBody: '.bd-posts-body',
    gaCheckbox: '.bd-group-action__checkbox-input'
  };

  var el = {
    bd: $('.bd'),
    bdPostsBody: $('.bd-posts-body'),
    post: $('.bd-post'),
    gaCheckbox: $('.bd-group-action__checkbox-input'),
    gaDeleteBtn: $('.bd-group-action__delete-btn'),
    gaPublishBtn: $('.bd-group-action__publish-btn'),
    checkboxes: $('.bd-post__checkbox-input'),
    title: $('.bd-post__title'),
    loadMoreBtn: $('.bd-posts-body__load-more-btn')
  };

  if(el.bd.length) {
    var selectedIds = []
    var getLastPostId = function() {
      return $(sel.bdPost).last().attr("data-id");
    }

    var evtListeners = {
      groupActionCheckboxListener: function() {
        el.gaCheckbox.change(function(evt) {
          if(el.gaCheckbox.prop('checked')) {
            $(sel.checkbox).each(function(a, htmlElem) {
              $htmlElem = $(htmlElem)

              if($htmlElem.is(':not(:checked)')) {
                $htmlElem.click();
              }
            })
          } else {
            $(sel.checkbox).each(function(a, htmlElem) {
              $htmlElem = $(htmlElem)

              if($htmlElem.is(':checked')) {
                $htmlElem.click();
              }
            })
          }
        });
      },
      bdPostTitleListener: function() {
        $(sel.bdPostTitle).click(function(evt) {
          evt.preventDefault();
          evt.stopPropagation();
          $(evt.target).parents(sel.bdPost).find(sel.checkbox).click();
        });
      },
      groupActionPublishBtnListener: function() {
        el.gaPublishBtn.click(function(evt) {
          evt.preventDefault();
          evt.stopPropagation();

          if(confirm(`Do you really want to publish ${selectedIds.length} articles?`)) {
            $.ajax({
              url: '/api/v1/articles/publish_group',
              method: 'PUT',
              data: {
                ids: selectedIds
              },
              success: function() {
                toastr.success(`Successfully published ${selectedIds.length} ${pluralize('article', selectedIds.length)}`);

                getDraftArticles(getLastPostId(), selectedIds.length);

                selectedIds.forEach( (x) => {
                  let $el = $(sel.bdPost).filter('[data-id=' + x + ']');
                  $el.remove();
                });

                $(sel.gaCheckbox).click();

                selectedIds = []
              }
            });
          }
        });
      },
      groupActionDeleteBtnListener: function() {
        el.gaDeleteBtn.click(function(evt) {
          evt.preventDefault();
          evt.stopPropagation();

          if(confirm(`Do you really want to delete ${selectedIds.length} articles?`)) {
            $.ajax({
              url: '/api/v1/articles/delete_group',
              method: 'DELETE',
              data: {
                ids: selectedIds
              },
              success: function() {
                toastr.success(`Successfully deleted ${selectedIds.length} ${pluralize('article', selectedIds.length)}`);

                getDraftArticles(getLastPostId(), selectedIds.length);

                selectedIds.forEach( (x) => {
                  let $el = $(sel.bdPost).filter('[data-id=' + x + ']');
                  $el.remove();
                });

                $(sel.gaCheckbox).click();

                selectedIds = []
              }
            });
          }
        });
      },
      bdPostCheckboxListener: function(mode = 'init', element = null) {
        if (mode === 'init') {
          $(sel.checkbox).change(function(evt) {
            evt.stopPropagation();
            var $eventEl = $(evt.target);
            var $bdPost = $($eventEl.parents(sel.bdPost));

            if($eventEl.prop('checked')) {
              selectedIds.push($bdPost.attr('data-id'));
            } else {
              selectedIds = selectedIds.filter(id => id !== $bdPost.attr('data-id'))
            }

            console.log(selectedIds);

            el.gaCheckbox.attr("data-selected-ids", selectedIds);
          });
        } else if (mode === 'element') {
          if(element) {
            $(element).find(sel.checkbox).click(function(evt) {
              evt.stopPropagation();
              var $eventEl = $(evt.target);
              var $bdPost = $($eventEl.parents(sel.bdPost));

              if($eventEl.prop('checked')) {
                selectedIds.push($bdPost.attr('data-id'));
              } else {
                selectedIds = selectedIds.filter(id => id !== $bdPost.attr('data-id'))
              }

              console.log(selectedIds);

              el.gaCheckbox.attr("data-selected-ids", selectedIds);
            });
          }
        }
      },

      bdLoadMoreBtnListener: function() {
        el.loadMoreBtn.click(function(evt) {
          evt.preventDefault();
          evt.stopPropagation();

          getDraftArticles(getLastPostId(), 6);
        });
      },

    };

    evtListeners.groupActionCheckboxListener();
    evtListeners.bdPostTitleListener();
    evtListeners.groupActionPublishBtnListener();
    evtListeners.groupActionDeleteBtnListener();
    evtListeners.bdPostCheckboxListener();
    evtListeners.bdLoadMoreBtnListener();

    function getDraftArticles (lastId, amount = 6) {
      return $.ajax({
        url: '/api/v1/articles/provide_draft_articles_as_html',
        data: {
          last_id: lastId,
          amount_of_articles: amount
        },
        success: function(html) {
          let parent = $('<div></div>');
          parent.append(html);
          bdPosts = parent.find(sel.bdPost);

          bdPosts.each( (i, el) => {
            evtListeners.bdPostCheckboxListener('element', el);
            $(sel.bdPostsBody).append(el);
          });
        }
      });
    };

  }
});

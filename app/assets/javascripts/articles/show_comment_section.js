$(document).ready(function() {
  $articleCmts = $('.article-cmts');

  if($articleCmts.length != 0) {
    var sel = {
      addCmtField: '.cmts-add-cmt-form__field',
      cmt: '.cmt',
      newCmtForm: '.cmts-add-cmt-form',
      cmtsBody: '.cmts-body',
      article: '.article',
      cmtReplyBtn: '.cmt__reply',
      cmtReplyFormCont: '.cmt__reply-form-cont',
      cmtReplyForm: '.cmt__reply-form',
      cmtRightCol: '.cmt__right-col',
      cmtRepliesCont: '.cmt__replies-cont',
      newReplyForm: '.cmt__reply-form',
      newReplyField: '.cmt__reply-field',
      upvoteBtn: '.cmt__upvote',
      downvoteBtn: '.cmt__downvote',
      viewRepliesBtn: '.cmt__view-replies-btn',
      repliesCont: '.cmt__replies-cont',
      voteCount: '.cmt__vote-count',
    }

    let articleId = $(sel.article).attr('data-id');

    function upvoteComment(evt) {
      evt.preventDefault();
      evt.stopPropagation();

      let commentId = $(evt.target).parents('.cmt').attr('data-id');

      $.ajax({
        url: '/api/v1/comments/' + commentId + '/upvote',
        method: 'PUT',
        headers: {
          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        data: {
          comment_id: commentId
        },
        success: function(data) {
          if(data.is_positive) {
            $(evt.target).parents('.cmt').find(sel.voteCount).html('<span class="positive-vote-count">' + data.vote_count + '</span>');
          } else {
            $(evt.target).parents('.cmt').find(sel.voteCount).html('<span class="negative-vote-count">' + data.vote_count + '</span>');
          }
        }
      });
    }

    function downvoteComment(evt) {
      evt.preventDefault();
      evt.stopPropagation();

      let commentId = $(evt.target).parents('.cmt').attr('data-id');

      $.ajax({
        url: '/api/v1/comments/' + commentId + '/downvote',
        method: 'PUT',
        headers: {
          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        data: {
          comment_id: commentId
        },
        success: function(data) {
          if(data.is_positive) {
            $(evt.target).parents('.cmt').find(sel.voteCount).html('<span class="positive-vote-count">' + data.vote_count + '</span>');
          } else {
            $(evt.target).parents('.cmt').find(sel.voteCount).html('<span class="negative-vote-count">' + data.vote_count + '</span>');
          }
        }
      });
    }

    function newReplySubmitForm(evt) {
      evt.preventDefault();
      evt.stopPropagation();

      let newCmtBody = $(evt.target).find(sel.newReplyField).val();
      console.log(newCmtBody);

      let parentCmtTree = $(evt.target).parents('.cmt-tree')
      let replyToId = $(evt.target).parents('.cmt').attr('data-id');
      console.log(replyToId);
      let $form = $(evt.target)

      $.ajax({
        url: '/articles/' + articleId + '/comments',
        data: {
          comment: {
            body: newCmtBody,
            is_reply: true,
            reply_to_id: replyToId
          }
        },
        headers: {
          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        method: 'POST',
        success: function(html) {
          toastr.success('You have successfully added a comment');
          $(sel.newReplyField).val('');
          $(sel.newReplyField).attr('rows', 1);
          let comment = addEventListeners(html);
          $form.parents('.cmt-tree').find(sel.cmtRepliesCont).prepend(comment);
          $form.parents('.cmt-tree').find(sel.repliesCont).show();

          $form.hide();
        }
      })
    }

    $(sel.addCmtField).focus(function(evt) {
      $el = $(evt.target);

      $el.keyup(function(evt) {
        let currentHeight = $el.attr('rows')
        let val = $el.val();
        let numLines = val.split('\n').length;
        console.log(currentHeight, val, numLines);
        if(numLines != currentHeight) {
          $el.attr('rows', numLines);
        }
      });
    });

    $(sel.newCmtForm).on('submit', function(evt) {
      evt.preventDefault();
      evt.stopPropagation();

      let newCmtBody = $(sel.addCmtField).val();

      console.log(evt);

      $.ajax({
        url: '/articles/' + articleId + '/comments',
        data: {
          comment: {
            body: newCmtBody
          }
        },
        headers: {
          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        method: 'POST',
        success: function(html) {
          let comment = addEventListeners(html);
          $(sel.cmtsBody).prepend(comment);
          toastr.success('You have successfully added a comment');
          $(sel.addCmtField).val('');
          $(sel.addCmtField).attr('rows', 1);
        }
      })
    });


    function addEventListeners(comment) {
      let cmtWithListeners = $(comment);
      cmtWithListeners.find(sel.cmtReplyBtn).click(function(evt) {
        evt.preventDefault();
        evt.stopPropagation();

        $(evt.target).parents(sel.cmtRightCol).find(sel.cmtReplyFormCont).show();
      });

      cmtWithListeners.find(sel.upvoteBtn).click(function(evt) {
        upvoteComment(evt);
      });

      cmtWithListeners.find(sel.downvoteBtn).click(function(evt) {
        downvoteComment(evt);
      });

      cmtWithListeners.find(sel.viewRepliesBtn).click(function() {
        $(sel.repliesCont).show();
      });

      cmtWithListeners.find(sel.newReplyForm).on('submit', function(evt) {
        newReplySubmitForm(evt);
      });

      return cmtWithListeners;
    }


    $(sel.cmtReplyBtn).click(function(evt) {
      evt.preventDefault();
      evt.stopPropagation();

      $(evt.target).parents(sel.cmtRightCol).find(sel.cmtReplyFormCont).show();
    });

    $(sel.newReplyField).focus(function(evt) {
      $el = $(evt.target);

      $el.keyup(function(evt) {
        let currentHeight = $el.attr('rows')
        let val = $el.val();
        let numLines = val.split('\n').length;
        console.log(currentHeight, val, numLines);
        if(numLines != currentHeight) {
          $el.attr('rows', numLines);
        }
      });
    });

    $(sel.newReplyForm).on('submit', function(evt) {
      newReplySubmitForm(evt);
    });

    $(sel.upvoteBtn).click(function(evt) {
      upvoteComment(evt);
    });

    $(sel.downvoteBtn).click(function(evt) {
      downvoteComment(evt);
    });

    $(sel.viewRepliesBtn).click(function() {
      $(sel.repliesCont).show();
    });
  }
});

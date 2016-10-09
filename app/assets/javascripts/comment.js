$(document).ready(function () {
  $('.addCommentForm').submit(function (event) {
    // console.log(this);
    // console.log(event.target);
    var form = event.target;
    var body, event_id, user_id, review_id, commenter_name;
    user_id = $(this).find('.commenterId').val();
    event_id = $(this).find('.commentEventId').val();
    review_id = $(this).find('.commentReviewId').val();

    // console.log(review_id);
    body = $(this).find('.commentBody').val();
    // console.log(body);

    $.ajax({

      url: '/events/' + event_id + '/' + review_id + '/comments/',

      type: 'POST',

      data: {
        comment: {
          user_id: user_id,
          event_id: event_id,
          review_id: review_id,
          body: body
        }
      }

    })

    .done(function (data) {
      Materialize.toast('Thanks for your comment', 3000);
      var clonedDiv = $('#comment').last().clone();
      // console.log(clonedDiv);
      clonedDiv.find('#commentBodyContent').html(data.body);
      // console.log(data.body);
      // filled_in_stars(data.rating, clonedDiv);
      // empty_stars(data.rating, clonedDiv);
      add_author_image(clonedDiv);
      add_author_name(clonedDiv);
      clonedDiv.removeAttr('style');
      clonedDiv.insertAfter($('#comment').last());
      empty_fields();
    })

    .fail(function () {
      Materialize.toast('Sorry, comment cannot be saved', 3000);
    });
    event.preventDefault();
  });

  function add_author_image(target_div) {
    var image_source = $('img.profile_pic').attr('src'),
        img = target_div.find('.comment-author-pic');
    img.attr('src', image_source);
  }

  function add_author_name(target_div) {
    var commenter_name = $('#currentUser').text().trim();
    // console.log(reviewers_name);
    target_div.find('.comment-author-name').html(commenter_name);
  }

  function empty_fields() {
    $('.commentBody').val('');
    $('input:checked').attr('checked', false);
  }
});
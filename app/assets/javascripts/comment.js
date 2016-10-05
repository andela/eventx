$(document).ready(function () {
  $('.addCommentForm').submit(function (event) {
    // console.log(this);
    // console.log(event.target);
    var form = event.target;
    var body, event_id, user_id, review_id, reviewers_name;
    user_id = $(this).find('.commenterId').val();
    event_id = $(this).find('.commentEventId').val();
    review_id = $(this).find('.commentReviewId').val();

    // console.log(review_id);
    body = $(this).find('.commentBody').val();
    console.log(body);

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
      Materialize.toast('Your comment has been saved', 3000);

    })

    .fail(function () {
      // console.log(url);
      Materialize.toast('Sorry, review cannot be saved', 3000);
    });
    event.preventDefault();
  });

  function filled_in_stars(number, target_div) {
    var stars = '';
    for (var i = 1; i <= number; i++) {
      stars += '<span class=\'filled-in-star star-size\'>&#9734;</span>';
    }
    target_div.find('.review-rating').html(stars);
  }

  function empty_stars(number, target_div) {
    var stars = '',
        count = 5 - number,
        html_string = '<span class=\'star-size\'>&#9734;</span>';

    for (var i = 1; i <= count; i++) { stars += html_string }
    target_div.find('.review-rating').append(stars);
  }

  function add_author_image(target_div) {
    var image_source = $('img.profile_pic').attr('src'),
        img = target_div.find('.review-author-pic');
    img.attr('src', image_source);
  }

  function add_author_name(target_div) {
    var reviewers_name = $('#currentUser').text().trim();
    // console.log(reviewers_name);
    target_div.find('.review-author-name').html(reviewers_name);
  }

  function empty_fields() {
    $('#reviewBody').val('');
    $('input:checked').attr('checked', false);
  }
});

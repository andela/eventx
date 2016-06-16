$(document).ready(function() {
  $('#addReview').click(function (){
      var body, event_id, user_id, rating, reviewers_name;
      body = $("#reviewBody").val()
      event_id = $('#reviewEventId').val();
      user_id = $('#reviewerId').val();
      rating = $( "input:checked" ).val();
      $.ajax({
        url: '/events/' + event_id + '/reviews',
        type: 'POST',
        data: { review: { body: body, event_id: event_id, rating: rating, user_id: user_id } }
      })
      .done(function(data){
        Materialize.toast('Your review has been saved', 3000);
        var clonedDiv = $('#review').clone();
        clonedDiv.find("#reviewBodyContent").html(data.body)
        filled_in_stars(data.rating, clonedDiv);
        empty_stars(data.rating, clonedDiv);
        add_author_image(clonedDiv);
        add_author_name(clonedDiv);
        clonedDiv.removeAttr("style");
        $('#review').after(clonedDiv);
      })
      .fail(function(){
        Materialize.toast('Sorry, review cannot be saved', 3000);
      });

      event.preventDefault()
    });

    function filled_in_stars(number, target_div){
      var stars = '';
      for(var i = 1; i <= number; i++){
        stars += '<span class="filled-in-star star-size">&#9734;</span>';
      }
      target_div.find(".review-rating").html(stars);
    };

    function empty_stars(number, target_div){
      var stars = '';
      count = 5 - number
      for(var i = 1; i <= count; i++){
        stars += '<span class="star-size">&#9734;</span>';
      }
      target_div.find(".review-rating").append(stars);
    };

    function add_author_image(target_div){
      image_source = $("img.profile_pic").attr("src")
      img = target_div.find(".review-author-pic");
      img.attr("src", image_source);
    };

    function add_author_name(target_div){
      reviewers_name = $("a.dropdown-button").text().trim();
      target_div.find(".review-author-name").html(reviewers_name)
    }
});

// $(document).ready(function(){
//     $(".responseButton").click(function(){
//         $(this).siblings("#responseForm").toggle()
//     })

//     $(".add-response-button").click(function(event){
//       console.log($(this).parents("#addResponseForm"))
//       event.preventDefault();
//       var body, event_id, user_id, reviewers_name, review_id;
//       body = $('#responseBody').val();
//       event_id = $('#responseEventId').val();
//       user_id = $('#responseId').val();
//       review_id = $('#reviewId').val();
//       console.log(body, event_id, user_id, review_id)
//       $.ajax({
//         url: '/events/' + event_id + '/reviews/' + review_id + '/reviews',
//         type: 'POST',
//         data: {
//           review: {
//             body: body,
//             event_id: event_id,
//             user_id: user_id
//           }
//         }
//       })

//      .done(function (data) {
//         Materialize.toast('Your response has been saved', 3000);

//           var responseAuthor = $('<div/>')
//         .addClass("response-author")
//         .append($("<img/>")
//           .attr('src', add_author_image())
//       )

//       var newResponse = $("<div/>")
//         .addClass("response")
//         .append(responseAuthor, reviewContent(data))

//       $("#newResponse").append(newResponse)



//       })

//       .fail(function () {
//         Materialize.toast('Sorry, review cannot be saved', 3000);
//       });
//       event.preventDefault();
//     });

//   function add_author_image() {
//     var image_source = $('img.profile_pic').attr('src');
//     //     img = target_div.find('.response-author-pic');
//     // img.attr('src', image_source);
//     console.log(image_source)
//     return image_source;
//   }

//     function reviewContent(data){
//       var content = $("<div></div>")
//         .addClass("review-content")
//         .append($("<div/>")
//           .addClass("review-header")
//           .append(
//             $('<h5/>')
//               .addClass("response-author-name")
//               .text(add_author_name())
//           )
//       )
//       .append(
//         $("<div/>")
//         .addClass('response-content-body')
//         .text(data.body)
//       )

//       return content;
//     }

//     function add_author_name() {
//       var reviewers_name = $('#currentUser').text().trim();
//       // console.log(reviewers_name);
//       // target_div.find('.response-author-name').html(reviewers_name);
//       return reviewers_name
//     }

//     function empty_fields() {
//       $('#responseBody').val('');
//     }
//     })
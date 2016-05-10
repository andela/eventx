$(document).ready(function(){
  $('#btn_category').click(function(e){
    data = {
      name: $('#category_name').val(),
      description: $('#category_description').val()
    };
    $.ajax({
      type: 'POST', 
      url: '/categories',
      data: data, 
      success:function(data){
        console.log(data.status);
      }, 
      error: function(data){
        console.log(data.status);
      }
    });
    e.preventDefault();
  });
});

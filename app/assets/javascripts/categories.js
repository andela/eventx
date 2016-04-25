$(document).ready(function(){

  // $('#btn_custom_cat').click(function(){
      
  //     $('#default_cat').hide();
  //     $('#txt_cat').show(); 
  // });

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

//$(document).ready(function(){
//     var notify = function(message){
//        Materialize.toast(message, 3000, "rounded");
//    };
//    var userExist = function (email) {
//        var users = [],
//            present = false;
//        $('.emails').each(function(index, item){
//            users.push(item.innerText);
//        });
//        users.forEach(function(value){
//            if (email == value) {
//                present = true;
//                return;
//            }
//        });
//
//        return present
//    };
//    $("#save_staff").on("click", function(e){
//        e.preventDefault();
//        var email = $('#ent_staff_email').val();
//        if(userExist(email)) {
//            notify("User already exist");
//            return false;
//        }
//    });
//});

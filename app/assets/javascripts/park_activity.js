$(function(){

  $('.subscribe_button').on('click',(function(event){

    $.ajax({
      url: subscriptions_path,
      method:'POST'
      data: {
            park_activity_id: ParkActivity.find(params[:id]).id,
            user_id: current_user.id },
      dataType: 'json' //json, text, html


//     }).done(function(data){
//       console.log(data);
//       var list = '<li class="tweet"><p>' + data.message + '</p><time>'+ data.created_at +'</time></li>';
//       $('.tweets').prepend(list);
//
//     }).fail(function(jqXHR, textStatus, errorThrown){
//       console.log('Ajax Request Failed');
//       console.log(jqXHR);
//     }).always(function(){
//       console.log('Ajax Request Sent');
//     });
//   });
// });
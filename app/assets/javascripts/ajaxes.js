$(document).ready(function(){
  $('#generate_pair').on('submit', generatePiar);

})


var generatePiar = function(event){
  event.preventDefault();
  $target = $(event.target);
  $.ajax({
    url: $target.attr('action'),
    type: $target.attr('method'),
    data: $target.serialize()
  }).done(function(response){
    $target.parent().siblings('#pair_list').empty()
    $target.parent().siblings('#pair_list').append(response)
  });
}

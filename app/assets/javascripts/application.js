// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require underscore
//= require leaflet
//= require rails_emoji_picker
//= require gmaps/google
//= require_tree .


$( document ).ready(function() {




  $('#searchbutton').click(function(){

    $('#results').empty();

    var queryinput = $('#queryinput').val();
    $('#queryinput').empty();



    $.ajax({
      url: "/posts/search",
      dataType: "json",
      method: "POST",
      data: {
        query: queryinput
      }
    }).done(function(data){
      // debugger;

      // remove existing markers
      markers.forEach(function(m){
        m.setMap(null);
        

      });
      markers = [];

      console.log('Search results:', data.length);
      console.log('markers', markers);
      for (var i = 0; i < data.length; i++) {

        var post = data[i];

        var user = $('<p>').text(post.username);
        var location= $('<p>').text(post.location);
        var userid = post.user_id;
        var user = post.user.username;
        var emoji = post.emjoi;
        var $question = $('<p>').text(post.question)
                                .addClass("questionlist")
                                .attr('post-id', post.id);

        // $('#results').append('<img>').attr("src", "/assets/images/mapicons/happy.png");
        $('#results').html('<img src="/assets/mapicons/' + emoji + '.png" height="20" width="20" />');

        $('#results').append(user,":").append($question);
        // $('#results').append(question);

        // $('#results').append("Location:", location);

        var m = handler.addMarker({
          id: post.id,
          infowindow: '<p><strong><u><a href="/posts/' + post.id + '">What is the meaning of life?</a></u></strong></p><p></p><p></p>',
          lat: post.latitude,
          lng: post.longitude,
          picture: {
            height: 60,
            width: 60,
            url: '/assets/mapicons/' + emoji + '.png'
          }
        });
        markers.push( m );

      } // for data.posts

      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();

    })
    .fail(function(xhr, err, status) {
      console.log(xhr, err, status);
    });



  });

  // Use event delegation
  $(document).on('click', '.questionlist', function(){
    var url = '/posts/' + $(this).attr('post-id');
    document.location.href = url;
  });


  /* James: Set the width of the side navigation to 250px for Sliding nav bar*/
      $("#navOpen").click(function(){
        $('#mySidenav').css('width', "250px");
      console.log('open, says me');
    })



  /* James: Set the width of the side navigation to 0 for sliding nav bar*/
      $("#navClose").click(function(){
        $('#mySidenav').css('width', "0");
      console.log('close, says me');
    })

});

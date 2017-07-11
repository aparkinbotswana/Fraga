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

      for (var i = 0; i < data.posts.length; i++) {
        var question = $('<p>').text(data.posts[i].question);
        var user = $('<p>').text(data.posts[i].username);
        var location= $('<p>').text(data.posts[i].location);
        var userid = data.posts[i].id;
        var user = "mr question man ";
        // var user = data.users[0].username;
        // var user = jQuery.grep(data.user, function(obj){
        //   return obj.id === userid });



        $('#results').append(user + "asks:");
        $('#results').append(question);
        $('#results').append(location);




      };








    })
    .fail(function(xhr, err, status) {
      console.log(xhr, err, status);
    });



  });














});

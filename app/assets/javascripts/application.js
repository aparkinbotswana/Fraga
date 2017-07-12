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
//= require_tree .


$( document ).ready(function() {

// Julian - search results


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



      for (var i = 0; i < data.length; i++) {
        console.log('added one');

        var post = data[i];

        var user = $('<p>').text(post.username);
        var location= post.location;
        var userid = post.user_id;
        var user = post.user.username;
        var emoji = post.emjoi;
        var $question = $('<h2>').text(post.question)
                                .addClass("questionlist")
                                .attr('post-id', post.id);

        // julian // append emoji image works but commented out...

        // $('#results').append('<img src="/assets/mapicons/' + emoji + '.png" height="20" width="20" />');

        var $usertext = $('<p>').text(user + ": " + location).addClass("usertext");
        $('#results').append('<div>').append($question).append($usertext).addClass("questiondiv");






      } // for data.posts



    })
    .fail(function(xhr, err, status) {
      console.log(xhr, err, status);
    });



  // Use event delegation
  $(document).on('click', '.questionlist', function(){
    var url = '/posts/' + $(this).attr('post-id');
    document.location.href = url;
  });


  /* James: Set the width of the side navigation to 250px for Sliding nav bar*/
      $("#navOpen").click(function(){
        $('#mySidenav').css('width', "550px");
      console.log('open, says me');
    })



  /* James: Set the width of the side navigation to 0 for sliding nav bar*/
    $("#navClose").click(function(){
        $('#mySidenav').css('width', "0");
      console.log('close, says me');
    })

  // Michelle: Translate text

var translateRequest = function(location, text, lang) {

  var baseURL = 'https://translate.yandex.net/api/v1.5/tr.json/translate';

  $.ajax ({
    url:baseURL,
    data: {
    key:"trnsl.1.1.20170711T112614Z.9c1df31075cbcee8.ec6091afcb695ca7edb3e449bb2b38e0d268fc58",
    text: text,
    lang: lang
    }
  })
  .done(function(res){
    console.log(res);
    var $div = $('<div>').html("Translation (" + lang + "): "+ res.text[0]);
    $(location).append($div);
    console.log($div);
  })
  .fail(function(xhr, status, err){
    console.log(xhr, status, err);
  })

}

  $('#postLanguageButton').click(function(){
    var languageRequest = $('#language').val();
    console.log(languageRequest);
    submitPost(languageRequest)
  })

  var submitPost = function(languageRequest){
    var line = $('h2').html();
    var location = 'h2';
    var lang = languageRequest;
    translateRequest(location, line,languageRequest)

  };

  $('#commentsLanguageButton').click(function(){
    var languageRequest = $('#language').val();
    console.log(languageRequest);
    submitComments(languageRequest)
  });

// Michelle - loop through class="translateComment" from show page to translate individual comments.
  var submitComments = function(languageRequest){
    var locationToTranslate = $(".translateComment");
    for (var i = 0; i < locationToTranslate.length; i++) {
      console.log(locationToTranslate[i]);
      var line = locationToTranslate[i].innerText;
      translateRequest(locationToTranslate[i], line, languageRequest)

    }

  }


});

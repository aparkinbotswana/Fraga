


















function initMap() {

  var myLatlng = {lat: -33.9, lng: 151.2};
  var mapOptions = {
  zoom: 12,
  center: myLatlng
  };



  var map = new google.maps.Map(document.getElementById("map"), mapOptions);
  // var map2 = new google.maps.Map(document.getElementById("mapshow"), mapOptions);

  setMarkers(map);
  // setMarkers(map2);
}




var questionz = [];

var markers = [];

var marker;
var question;
var infowindow;

function setMarkers(map) {



  var bounds = new google.maps.LatLngBounds();

  for (var i = 0; i < questionz.length; i++) {
      question = questionz[i];
      marker = new google.maps.Marker({
      position: {lat: question[1], lng: question[2]},
      map: map,
      icon: '/assets/mapicons/' + question[4] + '.png',
      title: question[0],
      zIndex: question[3]
    });



    // console.log(marker);



    // Julian --- add series of event listener to created marker


    (function () {

      google.maps.event.addListener(marker, 'click', function () {
        window.location.href = '/posts/' + question[3];
        });

         infowindow = new google.maps.InfoWindow({
         content: question[0]
       });

       google.maps.event.addListener(marker, 'mouseover', function() {
         infowindow.open(map, this)
       });

       google.maps.event.addListener(marker, 'mouseout', function() {
         infowindow.close(map, this)
       });

    })();




















      google.maps.event.addListener(marker, 'mouseover', function () {
        this.setAnimation(google.maps.Animation.BOUNCE);
    });


      google.maps.event.addListener(marker, 'mouseout', function () {
        this.setAnimation(null);
    });

    google.maps.event.addListener(marker, 'mouseover', function() {
    map.panTo(this.getPosition());
    });












    // Julian push created marker to markers array
    markers.push( marker );


    // Julian change zoom of map to a minimum zoom

    google.maps.event.addListener(map, 'zoom_changed', function() {
    zoomChangeBoundsListener =
        google.maps.event.addListener(map, 'bounds_changed', function(event) {
            if (this.getZoom() > 15 && this.initialZoom == true) {
                // Change max/min zoom here
                this.setZoom(15);
                this.initialZoom = false;
            }
        google.maps.event.removeListener(zoomChangeBoundsListener);
      });
    });
    map.initialZoom = true;



    // Julian set bounds position of marker

    bounds.extend( marker.getPosition() );




  } // for

  // Julian make zoom of map fit over all markers

  map.fitBounds(bounds);

};



$( document ).ready(function() {






  //





  // debugger;

$('#searchbutton').click(function(){
  mapload();
});

// Julian - search results

  var mapload = function(){

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

      // remove existing markers

      questionz = [];

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

        questionz.push([post.question,post.latitude,post.longitude,post.id,post.emjoi]);





      } // for data.posts

      initMap();




//------------------------------------------------------------------------------
// Julian -- when hovering over the search results --- the corresponding emoji bounces on the map

$( "h2" ).hover(
  function() {
    var index = $( "h2" ).index( this );
    markers[index].setAnimation(google.maps.Animation.BOUNCE);
    map.panTo(markers[index].getPosition());


  }, function() {
    var index = $( "h2" ).index( this );
    markers[index].setAnimation(null);
  }
);

//------------------------------------------------------------------------------



    })
    .fail(function(xhr, err, status) {
      console.log(xhr, err, status);
    });

  }; //search function close

  // call the rendering map function
  mapload();


  // Julian on click a item in the question list... go to its matching post
  $(document).on('click', '.questionlist', function(){
    var url = '/posts/' + $(this).attr('post-id');
    document.location.href = url;
  });










  /* James: Set the width of the side navigation to 250px for Sliding nav bar*/
      $("#navOpen").click(function(){
        $('#mySidenav').css('width', "544px");
        // $('#mySidenav').css('width', "32wh");
        $('#map').css('display', "absolute");
        $('#map').css('width', "68wh");
        $('#map').css('left', "34%");


      console.log('open, says me');

    })

  /* James: Set the width of the side navigation to 0 for sliding nav bar*/
    $("#navClose").click(function(){
        $('#mySidenav').css('width', "0");
        $('#map').css('display', "relative");
        $('#map').css('width', "100wh");
        $('#map').css('left', "0%");


      console.log('close, says me');
    })

    $("#searchOption").click(function(){
        $('#mySidenav').css('width', "0");
      console.log('close, says me');
    })

    $("#commentOption").click(function(){
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
  };



  $('.questionlist').click(function() {
 // initMap();
});







});

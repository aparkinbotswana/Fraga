function initMap() {

  var myLatlng = {lat: -33.9, lng: 151.2};
  var mapOptions = {
  zoom: 12,
  center: myLatlng
  };


  // var map = new google.maps.Map(document.getElementById('map'), {
  //   zoom: 10,
  //   center: myLatlng
  // });

  var map = new google.maps.Map(document.getElementById("map"), mapOptions);






  setMarkers(map);
}

// Data for the markers consisting of a name, a LatLng and a zIndex for the
// order in which these markers should display on top of each other.

var questionz = [
  ['Bondi Beach', -33.890542, 151.274856, 4],
  ['Coogee Beach', -33.923036, 151.259052, 5],
  ['Cronulla Beach', -34.028249, 151.157507, 3],
  ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
  ['Maroubra Beach', -33.950198, 151.259302, 1]
];



function setMarkers(map) {
  // Adds markers to the map.

  // Marker sizes are expressed as a Size of X,Y where the origin of the image
  // (0,0) is located in the top left of the image.

  // Origins, anchor positions and coordinates of the marker increase in the X
  // direction to the right and in the Y direction down.
  // var image = {


  //   url: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
  //   // This marker is 20 pixels wide by 32 pixels high.
  //   size: new google.maps.Size(20, 32),
  //   // The origin for this image is (0, 0).
  //   origin: new google.maps.Point(0, 0),
  //   // The anchor for this image is the base of the flagpole at (0, 32).
  //   anchor: new google.maps.Point(0, 32)
  // };
  // Shapes define the clickable region of the icon. The type defines an HTML
  // <area> element 'poly' which traces out a polygon as a series of X,Y points.
  // The final coordinate closes the poly by connecting to the first coordinate.
  var shape = {
    coords: [1, 1, 1, 20, 18, 20, 18, 1],
    type: 'poly'
  };

  for (var i = 0; i < questionz.length; i++) {
    var question = questionz[i];
    var marker = new google.maps.Marker({
      position: {lat: question[1], lng: question[2]},
      map: map,
      icon: '/assets/mapicons/' + question[4] + '.png',
      shape: shape,
      title: question[0],
      zIndex: question[3]
    });



    // marker.addListener('click', function() {
    // alert('clicked');
    // // map.setZoom(8);
    // // map.setCenter(marker.getPosition());
    // });




  }
};


// icon: '/assets/mapicons/' + image + '.png',















$( document ).ready(function() {

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

        initMap();





      } // for data.posts







    })
    .fail(function(xhr, err, status) {
      console.log(xhr, err, status);
    });


  }; //search function close


  mapload();








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







// maps stuff

















});

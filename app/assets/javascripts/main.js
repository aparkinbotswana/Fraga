


// julian question and search location script
$('.top.menu .item').tab();

function initMap() {
  var myLatlng = {lat: -33.9, lng: 151.2};
  var mapOptions = {
  zoom: 12,
  center: myLatlng,
  styles: myStyle
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
// var infowindow;
function setMarkers(map) {
  var bounds = new google.maps.LatLngBounds();
  for (var i = 0; i < questionz.length; i++) {
      question = questionz[i];
      marker = new google.maps.Marker({
      position: {lat: question[1], lng: question[2]},
      map: map,
      icon: '/assets/mapicons/' + question[4] + '.png',
      // title: question[0],
      zIndex: question[3],
      // hello:
      // This ID is used to contruct the correct show page URL in the click event
      fragaID: question[3],
      // This property defines an InfoWindow which the hover event uses
      fragaInfo: new google.maps.InfoWindow({
        content: question[0]
      })
    });
    // console.log(marker);
// ----------------------------------------------------------------------------
    // Julian --- add series of event listener to created marker
    // closure problem
      google.maps.event.addListener(marker, 'click', function () {
        window.location.href = '/posts/' + this.fragaID;
      });
       google.maps.event.addListener(marker, 'mouseover', function() {
         if(this.timerID){
           clearTimeout(this.timerID);
         }
        //  map.panTo(this.getPosition());
         this.setAnimation(google.maps.Animation.BOUNCE);
         this.fragaInfo.open(map, this);
       });
       google.maps.event.addListener(marker, 'mouseout', function() {
         var m = this;
         this.timerID = setTimeout(function () {
           m.fragaInfo.close(map, m);
           m.setAnimation(null);
         }, 500);
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
  // James: title fade in and fade out
  var count = 0;

  var count = 0;


 var fader = function () {
   $('#fragaAnimation').fadeOut(3000, function () {
     // after fade out:
     if (count === 0) {
       // random language
       var title = _.sample(ask).toUpperCase();
       $('#fragaAnimation').html(title).fadeIn(3000);
     } else {
       // FRAGA
       $('#fragaAnimation').html("FRÅGA").fadeIn(3000);
     }
     count = 1 - count;

   });
 };

 setInterval(fader, 6000);

 $('#fragaAnimation').click(function(){
   window.location = '/';
 });

 $(document).bind('keypress', function(e) {
 if(e.keyCode==13){
   $('#querySearchbutton').trigger('click');}
 });


 $('#querySearchbutton').click(function(){
   $('#results').empty();

   var queryinput = $('#queryinput').val();
   // var locqueryinput = $('#locqueryinput').val();
   var data = {
     query: queryinput
   };
   mapload(data);
 });

 $('#locationSearchbutton').click(function(){
   $('#results').empty();

   var locqueryinput = $('#locqueryinput').val();
   // var locqueryinput = $('#locqueryinput').val();
   var data = {
     locquery: locqueryinput
   };
   mapload(data);
 });

 // Julian - search results

   var mapload = function(data){

       $('#results').empty();

       var queryinput = $('#queryinput').val();
       var queryinput = $('#queryinput').is(':visible')
       // var locqueryinput = $('#locqueryinput').val();

       $('#queryinput').empty();
       // $('#locqueryinput').empty();

       console.log('do ajax');
       $.ajax({
         url: "/posts/search",
         dataType: "json",
         method: "POST",
         data: data
       }).done(function(data){

      // remove existing markers
      questionz = [];
      for (var i = 0; i < data.length; i++) {
        console.log('added one');
        var post = data[i];
        var user = $('<p>').text(post.username);
        var location = post.location;




        var userid = post.user_id;
        var user = post.user.username;
        var emoji = post.emjoi;
        var $question = $('<h2>').text(post.question)
                                .addClass("questionlist")
                                .addClass("header")
                                .attr('post-id', post.id);


        // julian // append emoji image works but commented out...
        // $('#results').append('<img src="/assets/mapicons/' + emoji + '.png" height="20" width="20" />');
        var $usertext = $('<div class="description">').text(" " + user).addClass("usertext");
        $('#results').append('<div class="questionbox">').append($question).append($usertext).addClass("questiondiv");

        questionz.push([post.question,post.latitude,post.longitude,post.id,post.emjoi]);
      } // for data.posts
      initMap();
//------------------------------------------------------------------------------
// Julian -- when hovering over the search results --- the corresponding emoji bounces on the map


$( "h2.questionlist" ).hover(
  function() {
    var index = $( "h2.questionlist" ).index( this );
    markers[index].setAnimation(google.maps.Animation.BOUNCE);
    // map.panTo(markers[index].getPosition());


  }, function() {
    var index = $( "h2.questionlist" ).index( this );
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

    // Julian on click magnify icon, open slider, on click again close slider

    $('#navOpen').on('click',function(){
      $('#locNav').css('display', "none");
      if($(this).attr('data-click-state') == 1) {
      $(this).attr('data-click-state', 0)

      $('#mySidenav').css('width', "34%");
      $('#map').css('display', "absolute");
      $('#map').css('width', "68wh");
      $('#map').css('left', "34%");

      } else {
      $(this).attr('data-click-state', 1)
      $('#mySidenav').css('width', "0%");
      $('#map').css('width', "100wh");
      $('#map').css('left', "0%");

      }

    });





    $("#questButt").click(function(){
      $('#locNav').css('display', "none")
      $('#searchNav').css('display', "block")
      $(this).addClass("active");
      $('#locButt').removeClass("active");

    })

    $("#locButt").click(function(){
      $('#locNav').css('display', "block")
      $('#searchNav').css('display', "none")
      $(this).addClass("active");
      $('#questButt').removeClass("active");

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
    var $div = $('<div class="translated">').html("Translation (" + lang + "): "+ res.text[0]);
    $(location).append($div);
    console.log($div);
  })
  .fail(function(xhr, status, err){
    console.log(xhr, status, err);
  })
}
  // $('#toLanguageButton').click(function(){
  //   $('.translated').empty();
  //   var languageRequest = $('#languageTo').val();
  //   console.log(languageRequest);
  //   submitPost(languageRequest)
  // })
  // var submitPost = function(languageRequest){
  //   var locationToTranslate = $(".translateComment");
  //    var lang = navigator.language;
  //    var browserLanguageConv = ("en"+languageRequest);
  //    for (var i = 0; i < locationToTranslate.length; i++) {
  //   console.log(locationToTranslate[i]);
  //      var line = locationToTranslate[i].innerText;
  //      translateRequest(locationToTranslate[i], line, browserLanguageConv)
  //    }
  // };
  $('#toLanguageButton').click(function(){
    $('.translated').empty();
    var languageRequest = $('#languageTo').val();
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

});
  $('.questionlist').click(function() {
 // initMap();
});

// Comments collapse - Andy


   $('.collapse-comments').click(function() {
     $(this).parent().children('.in-content').toggle()
     $(this).closest('li').children('ul').toggle();
     $(this).html($(this).text() == '[+]' ? '[-]' : '[+]');
    });



var ask = ["vra", "يطلب", "Soruşun", "спытаць", "питам", "জিজ্ঞাসা করা", "Pitajte", "Preguntar", "Pangutana", "dotázat se", "gofyn", "Spørg", "Fragen", "παρακαλώ", "ask", "demandu", "pedir", "Küsi", "Galdetu",
"پرسیدن", "kysyä", "demander", "a iarraidh", "Preguntar", "પુછવું", "tambaye", "पूछना", "pitati", "mande", "kérdez", "Հարցրեք", "meminta", "jụọ", "Spyrja","Chiedere", "לִשְׁאוֹל", "尋ねる","Takon", "ვკითხე", "Сұраңыз",
"សួរ", "ಕೇಳಿ", "청하다","ຖາມ", "Paklausk", "Jautāt", "manontany", "ui", "Прашајте", "ചോദിക്കൂ","Гэж асуув", "विचारा", "Tanya", "Staqsi", "မေးမြန်း", "सोध्नु", "vragen", "spørre", "Funsani", "ਪੁੱਛੋ", "zapytać",
"Pergunte", "cere", "просить", "අහන්න", "opýtať sa", "Vprašajte", "weydii", "kërkoj", "питати", "Botsa", "nanya", "Kuuliza","கேட்க", "అడగండి", "пурсидан", "ถาม", "Magtanong", "sormak", "Запитай", "پوچھو",
"hỏi", "פרעגן", "beere", "问", "问", "問", "Buza"];

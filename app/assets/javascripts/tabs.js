$(".nav-tabs a").click(function() {
  var position = $(this).parent().position();
  var width = $(this).parent().width();
    $(".slider").css({"left":+ position.left,"width":width});
});
var actWidth = $(".nav-tabs .active").width();
var actPosition = $(".nav-tabs .active").position();
$(".slider").css({"left":+ actPosition.left,"width": actWidth});

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#toggle_score_position")
		.on "click", () ->
      if($(".points").first().is(":visible"))
        $(".points").hide()
        $(".position").show()
        $(this).text("Toon score")
      else
        $(".points").show()
        $(".position").hide()
        $(this).text("Toon positie")


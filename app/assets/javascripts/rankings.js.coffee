# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#toggle_stage_scores")
		.on "click", () ->
      $(".total_points").hide()
      $(".stage_points").show()
      $(this).removeClass('btn-default')
      $(this).addClass('btn-primary')
      $("#toggle_scores").removeClass('btn-primary')
      $("#toggle_scores").addClass('btn-default')

  $("#toggle_scores")
    .on "click", () ->
      $(".total_points").show()
      $(".stage_points").hide()
      $(this).removeClass('btn-default')
      $(this).addClass('btn-primary')
      $("#toggle_stage_scores").removeClass('btn-primary')
      $("#toggle_stage_scores").addClass('btn-default')
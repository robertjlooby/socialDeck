# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#for new post form
$ -> # display the file input field when user selects photo or video
	$("#post_post_type_1, #post_post_type_2").on "click", ->
		$(".default-hidden").css "display", "block"

$ -> # hide and clear the file input field when user selects text only
	$("#post_post_type_0").on "click", ->
		$(".default-hidden").css "display", "none"
		$("#post_file").val ""

$ ->
	if $("input:checked").val() > 0
		$(".default-hidden").css "display", "block"

#for commenting on a post
$ ->
	postLables = $('[id^="post"][id$="-new-comment-link"]')
	for lable in postLables
		do(lable) ->
			postNum = lable.id[4]
			$ ->
				$("#post#{postNum}-new-comment-link").on "click", ->
					$("#post#{postNum}-new-comment").toggle()
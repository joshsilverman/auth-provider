# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    resizeContents = ->
      footer = $('#footer')
      contents = $('#main')
      header = $('#header')

      footerY = footer.height()
      contentsY = contents.height()
      headerY = header.height() + 15
      viewportY = $(window).height()

      difference = viewportY - footerY - headerY - 13;

      newContentsY = difference;

      #set min height
      contents.css('minHeight', newContentsY+'px')
      
      #move sign-in
      $("#main").css('minHeight', newContentsY+'px')

    #init
    init = -> resizeContents()
    init()
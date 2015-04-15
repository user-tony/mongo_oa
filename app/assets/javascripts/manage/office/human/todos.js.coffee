#
# * TODO: add a way to add more todo's to list
#
$(document.body).ready ->
  countTasks = ->
    $(".todo-group-title").each ->
      $this = $(this)
      $this.find(".num-of-tasks").text $this.next().find("li").size()
      return

    return

  # initialize sortable
  $ ->
    $("#sortable1, #sortable2").sortable(
      handle: ".handle"
      connectWith: ".todo"
      update: countTasks
    ).disableSelection()
    return


  # check and uncheck
  $(".todo .checkbox > input[type=\"checkbox\"]").click ->
    $this = $(this).parent().parent().parent()
    if $(this).prop("checked")
      $.ajax
        url: "/manage/office/human/todos/" + $(this).attr("value") + "/publish"
        type: "post"
        dataType: "script"
        data:
          _method: "put"

        context: this
        success: (data) ->
          return $this.addClass("complete")  if data.errors
          $(this).parent().hide()
          $this.slideUp 500, ->
            $this.clone().prependTo("#sortable3").effect "highlight", {}, 800
            $this.remove()
            countTasks()
            return

          return

    else
		# todo
    return

  return

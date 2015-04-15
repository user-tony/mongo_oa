$ ->
  $("input.datepicker").datepicker
    dateFormat: "yy-mm-dd"
    prevText: "<i class=\"fa fa-chevron-left\"></i>"
    nextText: "<i class=\"fa fa-chevron-right\"></i>"
    onSelect: (selectedDate) ->
      $("#finishdate").datepicker "option", "minDate", selectedDate
      return

  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()
  hdr =
    left: "title"
    center: "month,agendaWeek,agendaDay"
    right: "prev,today,next"

  $("#calendar").fullCalendar
    header: hdr
    buttonText:
      prev: "<i class=\"fa fa-chevron-left\"></i>"
      next: "<i class=\"fa fa-chevron-right\"></i>"

    editable: true
    droppable: true
    dragOpacity:
      agenda: .5
      "": .6
    eventRender: (event, element) ->
        element.find('.fc-event-title').append("<br/>" + event.description);
        element.find('.fc-event-title').addClass(event.className.join(' '));
        # element.find('span.fc-event-time').remove();

    eventDrop: (event, day, minute, all, revert) ->
      start = $.fullCalendar.formatDate(event["start"], "yyyy-MM-dd 08:mm:ss")
      end = $.fullCalendar.formatDate(event["end"], "yyyy-MM-dd  19:mm:ss")
      $.ajax
        url: $("form#add-event-form").attr("action") + "/" + event["id"] + "/publish"
        type: "post"
        dataType: "script"
        data:
          _method: "put"
          start_time: start
          end_time: end

        context: this
        success: (data) ->
          return  if data.errors

      return

    drop: (date, allDay) ->
      originalEventObject = $(this).parent().data("eventObject")
      copiedEventObject = $.extend({}, originalEventObject)
      copiedEventObject.start = date
      copiedEventObject.allDay = allDay
      $("#calendar").fullCalendar "renderEvent", copiedEventObject, true
      start = $.fullCalendar.formatDate(date, "yyyy-MM-dd  08:mm:ss")
      end = $.fullCalendar.formatDate(date, "yyyy-MM-dd  19:mm:ss")
      if $("#drop-remove").is(":checked")
        $.ajax
          url: $("form#add-event-form").attr("action") + "/" + originalEventObject["id"] + "/publish"
          type: "post"
          dataType: "script"
          data:
            _method: "put"
            start_time: start
            end_time: end

          context: this
          success: (data) ->
            $(this).remove()  if data.errors

      return

    select: (start, end, allDay) ->
      title = prompt("标题:")
      if title
        calendar.fullCalendar "renderEvent",
          title: title
          start: start
          end: end
          allDay: allDay
        , true
      calendar.fullCalendar "unselect"
      return

    events: $("form#add-event-form").attr("action"),
    eventMouseover: (event, jsEvent, view ) ->
        if ($(this).children('a').length != 0)
            return
        $(this).prepend('<a rel="nofollow" href="'+$("form#add-event-form").attr("action")+'/'+event['id']+'" data-method="delete" data-confirm="确定要删除吗？">删除</a>')
    eventMouseout: (event, jsEvent, view ) ->
        $(this).children('a').remove()

  $(document).on
    submit: ->
      $.ajax
        url: $("form#add-event-form").attr("action")
        type: "post"
        dataType: "json"
        data: $(this).serialize(),
        context: this
        success: (data) ->
          return if data.errors
          html = $("<li><span data-icon=\"fa-time\" data-description=\"" + data["description"] + "\" class=\"bg-color-" + data["color"] + " txt-color-white\" data_id=" + data["id"] + ">" + data["title"] + "</span></li>").prependTo("ul#external-events").hide().fadeIn()
          console.log html
          $("#event-container").effect "highlight", 800
          initDrag html
          return

      return
  , "form#add-event-form"

  initDrag = (e) ->
    eventObject =
      id: $.trim(e.children("span").attr("data_id"))
      title: $.trim(e.children().text())
      description: $.trim(e.children("span").attr("data-description"))
      icon: $.trim(e.children("span").attr("data-icon"))
      className: $.trim(e.children("span").attr("class"))

    e.data "eventObject", eventObject
    e.draggable
      zIndex: 999
      revert: true
      revertDuration: 0

    return

  $("#external-events > li").each ->
    initDrag $(this)
    return

  $(".fc-header-right, .fc-header-center").hide()
  $("#calendar-buttons #btn-prev").click ->
    $(".fc-button-prev").click()
    false

  $("#calendar-buttons #btn-next").click ->
    $(".fc-button-next").click()
    false

  $("#calendar-buttons #btn-today").click ->
    $(".fc-button-today").click()
    false

  $("#mt").click ->
    $("#calendar").fullCalendar "changeView", "month"
    return

  $("#ag").click ->
    $("#calendar").fullCalendar "changeView", "agendaWeek"
    return

  $("#td").click ->
    $("#calendar").fullCalendar "changeView", "agendaDay"
    return

  return

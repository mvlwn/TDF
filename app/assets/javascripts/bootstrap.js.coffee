jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $('[data-provide=datepicker]').datepicker( { format: 'yyyy-mm-dd', language: 'nl', todayBtn: true, calendarWeeks: true } );
# Eithery Lab, 2016.
# Event participants coffee scripts
# Performs client-side operations with event participants.

$(document).ready ->
  t = $('#event_participants').DataTable
    paging: false
    searching: false
    info: false
    columnDefs: [
      searchable: false
      orderable: false
      targets: [0, -1]
    ],
    order: [[1, 'asc']]

  t.on 'order.dt search.dt', ->
    t.column 0, search: 'applied', order: 'applied'
    .nodes().each (cell, i) ->
      cell.innerHTML = i + 1
  .draw()

  $('.combobox').combobox()

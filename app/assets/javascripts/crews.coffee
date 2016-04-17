# Eithery Lab, 2016.
# Crews coffee scripts
# Performs client-side operations with crews.

$(document).ready ->
  $('.bt-validation.crew form').formValidation
    framework: 'bootstrap'
    icon:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'

    fields:
      'crew[name]':
        validators:
          notEmpty:
            message: 'Crew name is required and cannot be empty'
          blank: {}

      'crew[native_name]':
        validators:
          notEmpty:
            message: 'Crew native name is required and cannot be empty'
          blank: {}


  t = $('#crews').DataTable
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

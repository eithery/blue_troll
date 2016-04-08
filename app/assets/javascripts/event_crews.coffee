# Eithery Lab, 2016.
# Event crews coffee scripts
# Performs client-side operations with event crews.

$(document).ready ->
  $('#event_crews').DataTable
    paging: false
    searching: false
    info: false
    columnDefs: [
      orderable: false
      targets: [0, -1]
    ]

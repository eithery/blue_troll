# Eithery Lab, 2016.
# Participants selector coffee scripts
# A client-side functionality for participants selector form.

$(document).ready ->
  $('#selected_participants').formValidation
    framework: 'bootstrap'
    icon:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'
    excluded: ':disabled'

    fields:
      'selected_participants[event_crew]':
        validators:
          notEmpty:
            message: 'Crew name is required and cannot be empty'


  $('#selected_participants').on 'change', (event) ->
    $('#selected_participants').formValidation 'revalidateField', 'selected_participants[event_crew]'

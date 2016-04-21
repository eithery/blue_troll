# Eithery Lab, 2016.
# Participants selector coffee scripts
# A client-side functionality for participants selector form.

$(document).ready ->
  $('.participants-selector').formValidation
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

  $('.participants-selector').on 'change', (event) ->
    console.log event
    $('.participants-selector').formValidation 'revalidateField', 'selected_participants[event_crew]'

# Eithery Lab, 2016.
# Participants coffee scripts
# Performs client-side operations with participants.

$(document).ready ->
  $('#new_participant').formValidation
    framework: 'bootstrap'
    icon:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'

    fields:
      'participant[last_name]':
        validators:
          notEmpty:
            message: 'Last name is required and cannot be empty'

      'participant[first_name]':
        validators:
          notEmpty:
            message: 'First name is required and cannot be empty'

      'participant[email]':
        validators:
          emailAddress:
            message: 'The value is not a valid email address'

      'participant[cell_phone]':
        validators:
          phone:
            country: 'US'
            message: 'The value is not a valid phone number'

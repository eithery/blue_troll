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

      'participant[age]':
        validators:
          digits:
            message: 'Age is not a number'
          between:
            min: 1
            max: 99
            message: 'Age must be between 1 and 99 years'
          callback:
            message: 'Age is required and cannot be empty for children'
            callback: (value, validator, $field) ->
              if $('#participant_age_category_adult').is(':checked')
                true
              else
                !!value

      'participant[email]':
        validators:
          emailAddress:
            message: 'The value is not a valid email address'

      'participant[phone]':
        validators:
          phone:
            country: 'US'
            message: 'The value is not a valid phone number'


  $('#participants').DataTable
    paging: false
    searching: false
    info: false

$(document).ready ->
  $('#new_session').formValidation
    framework: 'bootstrap'
    icon:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'

    fields:
      'session[login]':
        validators:
          notEmpty:
            message: 'User login/email field is required and cannot be empty'
          blank: {}

      'session[password]':
        validators:
          notEmpty:
            message: 'The password is required and cannot be empty'

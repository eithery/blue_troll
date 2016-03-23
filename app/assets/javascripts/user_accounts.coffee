$(document).ready ->
  $('#new_user_account').formValidation
    framework: 'bootstrap'
    icon:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'

    fields:
      'user_account[login]':
        validators:
          notEmpty:
            message: 'User login is required and cannot be empty'
          stringLength:
            min: 6
            message: 'User login should contain at least 6 symbols'

      'user_account[password]':
        validators:
          notEmpty:
            message: 'The password is reqired and cannot be empty'
          stringLength:
            min: 8
            message: 'The password should contain at least 8 symbols'

      'user_account[password_confirmation]':
        validators:
          notEmpty:
            message: 'The password confirmation is required'

      'user_account[email]':
        validators:
          notEmpty:
            message: 'The email address is required and cannot be empty'

      'user_account[email_confirmation]':
        validators:
          notEmpty:
            message: 'The email confirmation is required'

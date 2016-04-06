# Eithery Lab, 2016.
# UserAccounts coffee scripts
# Performs client-side operations with user accounts.

$(document).ready ->
  $('.new_user_account, .edit_user_account').formValidation
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
            min: 4
            message: 'User login should contain at least 4 symbols'
          blank: {}

      'user_account[password]':
        validators:
          notEmpty:
            message: 'The password is required and cannot be empty'
          stringLength:
            min: 8
            message: 'The password should contain at least 8 symbols'

      'user_account[password_confirmation]':
        validators:
          notEmpty:
            message: 'The password confirmation is required'
          identical:
            field: 'user_account[password]'
            message: 'The password and its confirmation are not the same'

      'user_account[email]':
        validators:
          notEmpty:
            message: 'The email address is required and cannot be empty'
          emailAddress:
            message: 'The value is not a valid email address'
          blank: {}

      'user_account[email_confirmation]':
        validators:
          notEmpty:
            message: 'The email confirmation is required'
          emailAddress:
            message: 'The value is not a valid email address'
          identical:
            field: 'user_account[email]'
            message: 'The email address and its confirmation are not the same'


  fv = $('.new_user_account, .edit_user_account').data 'formValidation'
  validation_message_attribute = 'data-validation-message'
  for e in $("[#{validation_message_attribute}]").toArray()
    msg = e.getAttribute validation_message_attribute
    unless msg is ''
      fv.updateMessage e.name, 'blank', msg
      fv.updateStatus e.name, 'INVALID', 'blank'

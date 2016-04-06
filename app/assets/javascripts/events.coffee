# Eithery Lab, 2016.
# Events coffee scripts
# Performs client-side operations with events.

$(document).ready ->
  $('#new_event').formValidation
    framework: 'bootstrap'
    icon:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'

    fields:
      'event[name]':
        validators:
          notEmpty:
            message: 'Event name is required and cannot be empty'
          blank: {}

      'event[short_name]':
        validators:
          notEmpty:
            message: 'Event short name is required and cannot be empty'
          blank: {}

      'event[started_on]':
        validators:
          notEmpty:
            message: 'Event start date is required and cannot be empty'
          date:
            format: 'MM/DD/YYYY'
            message: 'Event start date is invalid'

      'event[finished_on]':
        validators:
          notEmpty:
            message: 'Event end date is required and cannot be empty'
          date:
            format: 'MM/DD/YYYY'
            message: 'Event end date is invalid'
          callback:
            message: 'Event end date cannot be earlier than the start date'
            callback: (value, $validator, $field) ->
              $('#event_started_on').val() <= $('#event_finished_on').val()

      'event[address]':
        validators:
          notEmpty:
            message: 'Event address is required and cannot be empty'


  fv = $('#new_event').data 'formValidation'
  validation_message_attribute = 'data-validation-message'
  for e in $("[#{validation_message_attribute}]").toArray()
    msg = e.getAttribute validation_message_attribute
    unless msg is ''
      fv.updateMessage e.name, 'blank', msg
      fv.updateStatus e.name, 'INVALID', 'blank'

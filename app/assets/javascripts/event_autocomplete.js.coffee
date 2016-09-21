jQuery ->
  $('.add_staff_field').autocomplete
    delay: 500
    minLength: 1
    source: '/lookup_staffs'
    select: (event, ui) ->
      staffId = ui.item.data
      $('#staff_id').val(staffId)
    
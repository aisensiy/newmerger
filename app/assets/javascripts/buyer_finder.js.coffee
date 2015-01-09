$ ->
  fetch_reference_bargains_from_target_industry = () ->
    target_elem = '#reference_bargains_by_target_industry_container'
    request_path = '/buyer_finder/reference_bargains'
    trigger_elem = '#target_industry'
    $(trigger_elem).on('change', () ->
      industry_id = $(this).val()
      $.get(request_path, { industry_id: industry_id }, (html) ->
        $(target_elem).html(html)
      )
    )
  fetch_reference_bargains_from_target_industry()

  $('#target_industry').on('change', () ->
    $('#target_industry_hidden').val($(this).val())
  )

$ ->
  fetch_reference_bargains_from_buyer_industry = () ->
    buyer_elem = '#reference_bargains_by_buyer_industry_container'
    request_path = '/target_finder/reference_bargains'
    trigger_elem = '#buyer_industry'
    $(trigger_elem).on('change', () ->
      industry_id = $(this).val()
      $.get(request_path, { industry_id: industry_id }, (html) ->
        $(buyer_elem).html(html)
      )
    )
  fetch_reference_bargains_from_buyer_industry()

  $('#buyer_industry').on('change', () ->
    $('#buyer_industry_hidden').val($(this).val())
  )

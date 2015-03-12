$ ->
  $.getJSON('/industry/tree', (data) ->
    $tree = $('#industry_tree')
    $tree.tree({
      data: data,
      selectable: false,
      onCreateLi: (node, $li) ->
        # Append a link to the jqtree-element div.
        # The link has an url '#node-[id]' and a data property 'node-id'.
        $title = $li.find('.jqtree-element .jqtree-title')
        $elem = $("<input type='checkbox' class='edit' data-node-id='#{node.id}' />")
        $elem.insertBefore($title)
        if node.children.length > 0
          $elem.addClass('parent-node')
    })
    $tree.on('change', '.edit', (e) ->
      node_id = $(e.target).data('node-id')
      node = $tree.tree('getNodeById', node_id)
      $("[data-node-id]").filter(":not([data-node-id=#{node_id}])").prop('checked', false)
      if node.children
        for child in node.children
          $("[data-node-id=#{child.id}]").prop('checked', e.target.checked)
    )
  )

  fetch_reference_bargains_from_target_industry = (opt) ->
    opt ||= {}
    target_elem = opt.target_elem
    request_path = opt.request_path
    trigger_elem = opt.trigger_elem
    industry_select_elem = opt.industry_select_elem || '#industry_tree'
    hidden_industry_elem = opt.hidden_industry_elem

    industry_id = null
    $(trigger_elem).on('click', () ->
      return if $("#{industry_select_elem} [data-node-id]:checked").size() == 0

      if $("#{industry_select_elem} .parent-node[data-node-id]:checked").size()
        industry_id = $("#{industry_select_elem} .parent-node[data-node-id]:checked").data('node-id')
      else
        industry_id = $("#{industry_select_elem} [data-node-id]:checked").data('node-id')

      $.get(request_path, { industry_id: industry_id }, (html) ->
        $(target_elem).html(html)
      )
    )

    $(trigger_elem).on('click', () ->
      $(hidden_industry_elem).val(industry_id)
    )

  fetch_reference_bargains_from_target_industry({
    target_elem: '#reference_bargains_by_target_industry_container',
    request_path: '/buyer_finder/reference_bargains',
    trigger_elem: '#target_industry_btn',
    hidden_industry_elem: '#target_industry_hidden'
  })

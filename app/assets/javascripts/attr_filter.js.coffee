class AttrFilter
  constructor: (@container, @attr, @attr_text, @callback) ->
    @width = 440
    @height = 40
    @extent = null

  build: (values) ->
    self = this
    values.sort((a, b) ->
      if a[0] > b[0]
        1
      else if a[0] < b[0]
        -1
      else
        0
    )
    min_value = (_.min(values, (v) -> v[0]))[0]
    max_value = (_.max(values, (v) -> v[0]))[0]
    margin = {top: 15, right: 10, bottom: 10, left: 10}

    width =  @width - margin.left - margin.right
    height = @height - margin.top - margin.bottom

    svg = d3.select(@container).append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)

    svg.append('text')
        .attr('class', 'title')
        .attr('x', width / 2 - 70).attr('y', 10)
        .text(@attr_text || @attr)
        .style("font-size", "10px")

    g = svg.append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

    x = d3.scale.linear().range([0, width]).domain([min_value, max_value])
    y = d3.random.normal(height / 2, height / 8)

    circle = g.selectAll("circle").data(values).enter().append("circle")
        .attr("transform", (d) -> "translate(" + x(d[0]) + "," + y() + ")")
        .attr("r", 2)
        .attr("class", (d) -> d[1])

    brushstart = () ->
      svg.classed('selecting', true)

    brushmove = () ->
      extent0 = brush.extent()
      extent1 = null

      # init reset style
      if not d3.event
        circle.classed("selected", (d) -> extent0[0] <= d[0] && d[0] <= extent0[1])
        svg.select('text.title').text("#{self.attr_text} #{extent0[0]} - #{extent0[1]}")
        return

      # if dragging, preserve the width of the extent
      if d3.event.mode == "move"
        d0 = Math.round(extent0[0])
        d1 = d0 + extent0[1] - extent0[0]
        extent1 = [d0, d1]
      else # otherwise, if resizing, round both dates
        d0 = Math.round(extent0[0])
        d1 = Math.round(extent0[1])
        extent1 = [d0, d1]

        if extent1[0] >= extent1[1]
          extent1[0] = Math.floor(extent0[0])
          extent1[1] = Math.ceil(extent0[1])

      extent1 = _.map(extent1, Math.round)
      d3.select(this).call(brush.extent(extent1))

      circle.classed("selected", (d) -> extent1[0] <= d[0] && d[0] <= extent1[1])
      self.callback.call(svg, extent1) if self.callback
      self.extent = extent1
      svg.select('text.title').text("#{self.attr_text} #{extent1[0]} - #{extent1[1]}")

    brushend = () ->
        svg.classed("selecting", !d3.event.target.empty())

    brush = d3.svg.brush()
        .x(x)
        .extent([min_value, max_value])
        .on("brushstart", brushstart)
        .on("brush", brushmove)
        .on("brushend", brushend)

    arc = d3.svg.arc()
        .outerRadius(height / 2)
        .startAngle(0)
        .endAngle((d, i) ->
          if i then -Math.PI else Math.PI
        )

    brushg = g.append("g")
        .attr("class", "brush")
        .call(brush)

    brushg.selectAll(".resize").append("path")
        .attr("transform", "translate(0," +  height / 2 + ")")
        .attr('d', arc)

    brushg.selectAll("rect")
        .attr("height", height)

    brushstart()
    brushmove()

window.AttrFilter = AttrFilter

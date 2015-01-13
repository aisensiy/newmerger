// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require ace-extra.min
//= require ace.min
//= require d3.min
//= require underscore-min
//= require attr_filter
//= require buyer_finder
//= require target_finder

$(document).on('click', 'th input:checkbox' , function(){
  var that = this;
  $(this).closest('table').find('tr > td:first-child input:checkbox')
  .each(function(){
    this.checked = that.checked;
    $(this).closest('tr').toggleClass('selected');
  });
});

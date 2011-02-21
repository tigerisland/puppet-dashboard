jQuery(document).ready(function() {
  init_hosts();
});

function init_hosts() {
  jQuery( '#host-summary tbody tr.host' ).click( lightbox );
}

var lightbox = function() {
  jQuery( this ).colorbox({ href: '/node-report-summary.html' });
}

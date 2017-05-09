// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'
$(function(){
	$('#date_from').datepicker({dateFormat: 'dd-mm-yy'});
	$('#date_to').datepicker({dateFormat: 'dd-mm-yy'});
});

function printZpl(zpl) {
  var printWindow = window.open();
  printWindow.document.open('text/plain')
  printWindow.document.write(zpl);
  printWindow.document.close();
  printWindow.focus();
  printWindow.print();
  printWindow.close();
};
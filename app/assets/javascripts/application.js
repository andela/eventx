// This is a manifest file that"ll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin"s vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It"s not advisable to add code directly here, but if you do, it"ll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require cocoon
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require materialize-sprockets
//= require social-share-button
//= require_tree .
/*jshint -W030 */
/*jshint -W082 */
$('.timepicker').pickatime({
  twelvehour: true,
  donetext: 'Done',
  beforeShow: function () {
    activeElement = $(document.activeElement);
    activeForm = activeElement.closest('form')[0];
    // Remove existing validation errors
    activeForm.ClientSideValidations.removeError(activeElement);
    // Prevent a validation error occurring when element un-focusses
    activeElement.disableClientSideValidations();
  },
  afterDone: function () {
    activeElement = $(document.activeElement);
    $(activeElement).enableClientSideValidations();
  }
});
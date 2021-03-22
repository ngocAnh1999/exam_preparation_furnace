// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

require("material-kit/assets/js/core/jquery.min.js")
require('material-kit/assets/js/core/popper.min.js')
require("material-kit/assets/js/core/bootstrap-material-design.min.js")
require("material-kit/assets/js/plugins/moment.min.js")
require("material-kit/assets/js/plugins/bootstrap-datetimepicker.js")
require("material-kit/assets/js/plugins/nouislider.min.js")
// require("material-kit/assets/js/material-kit.min.js")
// require("material-kit/assets/js/plugins/jquery.sharrre.js")
// require("material-kit/assets/js/plugins/nouislider.min.js")
// require("material-kit/assets/js/plugins/moment.min.js")
// require("material-kit/assets/js/plugins/jquery.sharrre.js")
// require("material-kit/assets/js/plugins/bootstrap-datetimepicker.js")
require("@fortawesome/fontawesome-free")

global.toastr = require("toastr")
import "../stylesheets/application"

toastr.options = {
  "closeButton": false,

  "positionClass": "toast-top-right",

  "preventDuplicates": false,

  "onclick": null,

  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}

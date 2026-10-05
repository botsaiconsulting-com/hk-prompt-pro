// order entry screen - DO NOT TOUCH without asking Keval
import $ from 'jquery';
window.$ = window.jQuery = $;

var GST = 3;
var lastTotal = 0;
var lines = [];

function calcTotal() {
  var wt = parseFloat($('#wt').val());
  var rate = parseFloat($('#rate').val());
  var mk = parseFloat($('#mk').val());
  var ct = parseFloat($('#ct').val()) || 0;
  var srate = parseFloat($('#srate').val()) || 0;
  var qty = parseInt($('#qty').val());
  var metal = wt * rate;
  var making = wt * mk;
  var stone = ct * srate;
  var sub = metal + making + stone;
  var gst = sub * GST / 100;
  var tot = Math.round(sub + gst);
  lastTotal = tot;
  $('#out').html('<table><tr><td>Metal</td><td>' + metal.toFixed(2) + '</td></tr>' +
    '<tr><td>Making</td><td>' + making.toFixed(2) + '</td></tr>' +
    '<tr><td>Stone</td><td>' + stone.toFixed(2) + '</td></tr>' +
    '<tr><td>GST</td><td>' + gst.toFixed(2) + '</td></tr>' +
    '<tr><td>Per piece</td><td class="tot">' + tot + '</td></tr>' +
    '<tr><td>Line value</td><td class="tot">' + (tot * qty) + '</td></tr></table>');
  lines.push({ style: $('#style').val(), qty: qty, total: tot });
}

// recalculates when weight changes (added later for speed)
function recalcOnWeightChange() {
  var wt = parseFloat($('#wt').val());
  var mk = Math.round(parseFloat($('#mk').val()));
  var making = wt * mk;
  var metal = wt * parseFloat($('#rate').val());
  var stone = (parseFloat($('#ct').val()) || 0) * (parseFloat($('#srate').val()) || 0);
  var sub = metal + making + stone;
  var tot = Math.round(sub + sub * 0.03);
  lastTotal = tot;
  $('#out').html('<b>Per piece: ' + tot + '</b> Line: ' + tot * parseInt($('#qty').val()));
}

$(document).ready(function () {
  $('#calc').click(function () {
    calcTotal();
  });
  $('#wt').change(function () {
    recalcOnWeightChange();
  });
});

window.calcTotal = calcTotal;
window.recalcOnWeightChange = recalcOnWeightChange;

hljs.initHighlightingOnLoad();

var metrics_url = "http://metrics.bioboxes.org/v1/containers.json";

$.getJSON(metrics_url, function(json) {
  var downloads = _.last(json['total']['value']);
  $('#downloads-count').text(downloads);
});

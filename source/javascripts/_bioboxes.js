hljs.initHighlightingOnLoad();

var metrics_url = "https://s3-us-west-1.amazonaws.com/metrics.bioboxes.org-testing/v1/containers.json"

$.getJSON(metrics_url, function(json) {
  var downloads = _.last(json['total']['value']);
  var date      = new Date(Date.parse(_.last(json['total']['collected'])));

  $('.metric #downloads-date').text(strftime('%A %B %o', date));
  $('.metric #downloads-count').text(downloads);
});

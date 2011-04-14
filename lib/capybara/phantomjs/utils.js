document._getElementsByXPath = function(expression) {
  var results = [];
  var query = document.evaluate(expression, document,
      null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
  for (var i = 0, length = query.snapshotLength; i < length; i++)
      results.push(query.snapshotItem(i));
  return results;
};

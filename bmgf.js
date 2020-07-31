// bmfg.js

var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'bmgf.html'

page.open('https://www.gatesfoundation.org/How-We-Work/Quick-Links/Grants-Database#q/issue=Agricultural%20Development&page=2', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});
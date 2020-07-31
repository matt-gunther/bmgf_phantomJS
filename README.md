R and phantomJS: scraping a BMGF grantee database
================
Matt Gunther
31 July, 2020

[phamtomJS](https://github.com/ariya/phantomjs) is
([was?](https://github.com/ariya/phantomjs/issues/15344)) a headless
WebKit scriptable with JavaScript. This is an example showing how
phantomJS can be used to render dynamic content for
[rvest](https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/),
which reads HTML content into R. In this case, I located CSS fields with
[SelectorGadget](https://selectorgadget.com/) and fed them to rvest (but
Xpath is also fine).

I’m scraping a database containing all awards from the Bill & Melinda
Gates Foundation in the Agricultural Development issue area, as listed
[here](https://www.gatesfoundation.org/how-we-work/quick-links/grants-database#q/issue=Agricultural%20Development).
Although it’s easy enough to [use a JSON query for this
project](https://github.com/mgunther87/bmgf_scrape), the results table
provides a good test-case for phantomJS: each page of the table is
rendered at the same URL.

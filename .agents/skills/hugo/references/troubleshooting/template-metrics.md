## Template metrics

Hugo is fast, but inefficient templates impede performance. Enable template metrics to determine which templates take the most time, and to identify caching opportunities:

```sh
hugo build --templateMetrics --templateMetricsHints
```

The result will look something like this:

```text
Template Metrics:

     cumulative       average       maximum      cache  percent  cached  total
       duration      duration      duration  potential   cached   count  count  template
     ----------      --------      --------  ---------  -------  ------  -----  --------
  36.037476822s  135.990478ms  225.765245ms         11        0       0    265  _partials/head.html
  35.920040902s  164.018451ms  233.475072ms          0        0       0    219  articles/page.html
  34.163268129s  128.917992ms  224.816751ms         23        0       0    265  _partials/head/meta/opengraph.html
   1.041227437s     3.92916ms  186.303376ms         47        0       0    265  _partials/head/meta/schema.html
   805.628827ms   27.780304ms  114.678523ms          0        0       0     29  section.html
    624.08354ms   15.221549ms  108.420729ms          8        0       0     41  _partials/utilities/render-page-collection.html
   545.968801ms     775.523µs  105.045775ms          0        0       0    704  summary.html
   334.680981ms    1.262947ms  127.412027ms        100        0       0    265  _partials/head/js.html
   272.763205ms    2.050851ms   24.371757ms          0        0       0    133  _markup/render-codeblock.html
   163.951469ms   14.904679ms   70.267953ms          0        0       0     11  articles/section.html
    153.07021ms     577.623µs   73.593597ms        100        0       0    265  _partials/head/init.html
   150.910984ms  150.910984ms  150.910984ms          0        0       0      1  page.html
   146.785804ms  146.785804ms  146.785804ms          0        0       0      1  contact.html
   115.364617ms  115.364617ms  115.364617ms          0        0       0      1  authors/term.html
    87.392071ms     329.781µs   10.687132ms        100        0       0    265  _partials/head/css.html
    86.803122ms   86.803122ms   86.803122ms          0        0       0      1  home.html
```

From left to right, the columns represent:

cumulative duration
: The cumulative time spent executing the template.

average duration
: The average time spent executing the template.

maximum duration
: The maximum time spent executing the template.

cache potential
: Displayed as a percentage, any _partial_ template with a 100% cache potential should be called with the [`partialCached`][] function instead of the [`partial`][] function. See the [caching](#caching) section below.

percent cached
: The number of times the rendered templated was cached divided by the number of times the template was executed.

cached count
: The number of times the rendered templated was cached.

total count
: The number of times the template was executed.

template
: The path to the template, relative to the `layouts` directory.

> [!NOTE]
> Hugo builds pages in parallel where multiple pages are generated simultaneously. Because of this parallelism, the sum of "cumulative duration" values is usually greater than the actual time it takes to build a site.


How to use Optimize_AB
---------------------------------------
Taken from but altered slightly:
http://support.google.com/websiteoptimizer/bin/static.py?hl=en&topic=29622&guide=29619&page=guide.cs#m2


Multi-Variate Control & Tracking Script
---------------------------------------
The control script goes on your test page and makes sure that the experiment variations are switched randomly and that all variations are displayed an equal number of times.

The tracking script goes on your test page ensures that visits to the page are recorded in the experiment.

The control script immediately after the <pre><code><head></code></pre> tag.

    mv_head(k, ua, pv)

Arguements can be taken directly form the Google Optimize Website Script code


Multi-Variate Page Sections Scripts
---------------------------------------
The page sections script is used to mark
the elements that will be varied during the experiment. Essentially, you need to use the script provided by Website Optimizer to define the beginning and end of each element. For each element, you will need to name the page section in the script. As an example, let's say you defined a header that welcomes people to your page. The starting HTML code looks like this:

    <h1>Welcome!</h1>

After adding your section script, the header will look like this
(with the custom name "Headline" for this section in italics):

    <h1>
      <%= mv_begin_section("Headline") %>
        Welcome!
      <%= end_section %>
    </h1>

in HAML a link might be written as:

    = link_to (mv_begin_section('Headline') + "Welcome" + mv_end_section)


OnClick Conversion
---------------------------------------
You'll need to add a snippet of text to the link or links
that you want to track as a conversion. Let's say your link
looks like this:

    <a href="http://www.example.com/promotion">Featured Products</a>

To count a conversion when this link is clicked, add:

    onclick="doGoal(this);return false;"

to the HTML tag. The new link will look like this
(addition in bold):

    <a href="http://www.example.com/promotion" onclick="doGoal(this);return false;">Featured Products</a>

You can modify as many links as you want to count as a conversion,
but all of them will be counted identically as conversions in your
experiment results. In other words, Website Optimizer will not
differentiate between them when reporting conversions.



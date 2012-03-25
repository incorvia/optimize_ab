module Helpers

  ###################################################################
  #
  # How to use Optimize_AB
  # ---------------------------------------
  # Taken from but altered slightly:
  # http://support.google.com/websiteoptimizer/bin/static.py?hl=en&topic=29622&guide=29619&page=guide.cs#m2
  #
  #
  # Multi-Variate Control & Tracking Script
  # ---------------------------------------
  # The control script goes on your test page and makes sure that
  # the experiment variations are switched randomly and that all
  # variations are displayed an equal number of times.
  #
  # The tracking script goes on your test page ensures that visits
  # to the page are recorded in the experiment.
  #
  # The control script immediately after the <head> tag.
  #
  #
  # Page Sections Scripts
  # ---------------------------------------
  # The page sections script is used to mark
  # the elements that will be varied during the experiment.
  # Essentially, you need to use the script provided by Website
  # Optimizer to define the beginning and end of each element. For
  # each element, you will need to name the page section in the script.
  # As an example, let's say you defined a header that welcomes
  # people to your page. The starting HTML code looks like this:
  #
  # <h1>Welcome!</h1>
  #
  # After adding your section script, the header will look like this
  # (with the custom name "Headline" for this section in italics):
  #
  # <h1>
  #   <%= multi_begin_section("Headline") %>
  #     Welcome!
  #   <%= multi_end_section %>
  # </h1>
  #
  # in HAML a link might be written as:
  #
  # = link_to (multi_begin_section('Headline') + "Welcome" + multi_end_section)
  #
  #
  # OnClick Conversion
  # ---------------------------------------
  # You'll need to add a snippet of text to the link or links
  # that you want to track as a conversion. Let's say your link
  # looks like this:
  #
  # <a href="http://www.example.com/promotion">Featured Products</a>
  #
  # To count a conversion when this link is clicked, add:
  #
  # onclick="doGoal(this);return false;"
  #
  # to the HTML tag. The new link will look like this
  # (addition in bold):
  #
  # <a href="http://www.example.com/promotion" onclick="doGoal(this);return false;">Featured Products</a>
  #
  # You can modify as many links as you want to count as a conversion,
  # but all of them will be counted identically as conversions in your
  # experiment results. In other words, Website Optimizer will not
  # differentiate between them when reporting conversions.
  #
  ####################################################################


  ######## Control / Tracking Script / Click Function ########

  def ab_head(k, ua, pv)
    js = <<-HTML
      <script>
        function utmx_section(){}function utmx(){}
        (function(){var k="#{k}",d=document,l=d.location,c=d.cookie;function f(n){
        if(c){var i=c.indexOf(n+'=');if(i>-1){var j=c.indexOf(';',i);return escape(c.substring(i+n.
        length+1,j<0?c.length:j))}}}var x=f('__utmx'),xx=f('__utmxx'),h=l.hash;
        d.write('<sc'+'ript src="'+
        'http'+(l.protocol=='https:'?'s://ssl':'://www')+'.google-analytics.com'
        +'/siteopt.js?v=1&utmxkey='+k+'&utmx='+(x?x:'')+'&utmxx='+(xx?xx:'')+'&utmxtime='
        +new Date().valueOf()+(h?'&utmxhash='+escape(h.substr(1)):'')+
        '" type="text/javascript" charset="utf-8"></sc'+'ript>')})();
      </script>
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['gwo._setAccount', "#{ua}"]);
        _gaq.push(['gwo._trackPageview', "#{pv}"]);
        function doGoal(that) {
         try {
          _gaq.push(['gwo._trackPageview', "#{pv}"]);
          setTimeout('document.location = "' + that.href + '"', 100)
         }
         catch(err){}
        }
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
    HTML
    return js.html_safe
  end


  ######## Page Sections Scripts ########

  def ab_section(name)
    js = <<-HTML
      <script>utmx_section("#{name}")</script>
    HTML
    return js.html_safe
  end

  def ab_section
    js = <<-HTML
      </noscript>
    HTML
    return js.html_safe
  end
end

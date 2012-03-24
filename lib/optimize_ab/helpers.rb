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
  # Page sections scripts
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
  #
  # Conversion Script
  # ---------------------------------------
  # The conversion script tracks visits to your conversion page and
  # should be placed immediately before the closing </head> tag on
  # your conversion page.
  #
  #
  # OnClick Conversion Script
  # ---------------------------------------
  # The conversion script tracks visits to your conversion page and
  # should be placed immediately before the closing </head> tag on
  # your conversion page.
  #
  # Next, you'll need to add a snippet of text to the link or links that you want to track as a conversion. Let's say your link looks like this:
  # 
  # <a href="http://www.example.com/promotion">Featured Products</a>
  #
  # To count a conversion when this link is clicked, add onclick="doGoal(this);return false;" to the HTML tag. The new link will look like this (addition in bold):
  #
  # <a href="http://www.example.com/promotion" onclick="doGoal(this);return false;">Featured Products</a>
  #
  ####################################################################


  ######## Multi-Variate Control & Tracking Script ########

  def multi_head(k, ua, pv)
    js = <<-HTML
      <!-- Google Website Optimizer Control Script -->
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
      </script><script>utmx("url",'A/B');</script>
      <!-- End of Google Website Optimizer Control Script -->
      <!-- Google Website Optimizer Tracking Script -->
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['gwo._setAccount', "#{ua}"]);
        _gaq.push(['gwo._trackPageview', "#{pv}"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      <!-- End of Google Website Optimizer Tracking Script -->
    HTML
    return js.html_safe
  end


  ######## Page Sections Scripts ########

  def multi_begin_section(name)
    js = <<-HTML
      <script>utmx_section("#{name}")</script>
    HTML
    return js.html_safe
  end

  def multi_end_section
    js = <<-HTML
      </noscript>
    HTML
    return js.html_safe
  end


  ######## Mutli-Conversion Script ########

  def multi_converstion(ua, pv)
    js = <<-HTML
      <!-- Google Website Optimizer Tracking Script -->
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['gwo._setAccount', "#{ua}"]);
        _gaq.push(['gwo._trackPageview', "#{pv}"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      <!-- End of Google Website Optimizer Tracking Script -->
    HTML
    return js.html_safe
  end

  ######## OnClick Conversion Script ########

  def multi_on_click_converstion(ua, pv)
    js = <<-HTML
      <!-- Google Website Optimizer Tracking Script -->
       <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['gwo._setAccount', "#{ua}"]);
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
      <!-- End of Google Website Optimizer Tracking Script -->
    HTML
    return js.html_safe
  end
end

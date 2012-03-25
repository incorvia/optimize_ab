module Helpers

  ######## Multi-Variate Control / Tracking Script / Click Function ########

  def mv_head(k, ua, pv)
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
        _gaq.push(['gwo._trackPageview', "#{'/' + pv.to_s + '/test'}"]);
        function doGoal(that) {
         try {
          _gaq.push(['gwo._trackPageview', "#{'/' + pv.to_s + '/goal'}"]);
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


  ######## Multi-Variate Page Sections Scripts ########

  def mv_begin_section(name)
    js = <<-HTML
      <script>utmx_section("#{name}")</script>
    HTML
    return js.html_safe
  end

  def mv_end_section
    js = <<-HTML
      </noscript>
    HTML
    return js.html_safe
  end
end

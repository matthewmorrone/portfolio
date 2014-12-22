function isOffline() {
  return !(typeof navigator.onLine === 'undefined' || navigator.onLine);
}
function loadScript(url, id, async, callback) {
  var d = document, s = "script";
  if (id && d.getElementById(id)) {
    return;
  }
  var js = d.createElement(s), fjs = d.getElementsByTagName(s)[0], loaded;
  id && (js.id = id);
  async && (js.async = async);
  callback && js.addEventListener('load', callback, false);
  // (script.onreadystatechange = script.onload = function() { !loaded &&
  // callback(); loaded = true; };)
  js.src = url;
  fjs.parentNode.insertBefore(js, fjs);
}

setTimeout(function() {
  if (isOffline())
    return;

  (function(i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function() {
      (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date();
    a = s.createElement(o), m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
  })(window, document, 'script', '//www.google-analytics.com/analytics.js',
      'ga');
  ga('create', 'UA-32820551-1', 'piqnt.com');
  ga('send', 'pageview');

  WebFontConfig = {
    google : {
      families : [ 'Ubuntu:400,700:latin' ]
    }
  };
  loadScript(('https:' == document.location.protocol ? 'https' : 'http')
      + '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js', "", true);

}, 1);

setTimeout(function() {
  if (isOffline())
    return;
  loadScript("https://platform.twitter.com/widgets.js", "twitter-wjs", true);
  loadScript("https://connect.facebook.net/en_US/all.js"
      + "#xfbml=1&appId=112845592187492", "facebook-jssdk", true);
  loadScript("https://apis.google.com/js/plusone.js", "plusone-js", true);

  if (document.getElementById("livefyre-comments")) {
    loadScript("http://zor.livefyre.com/wjs/v3.0/javascripts/livefyre.js", "",
        true, function() {
          var articleId = fyre.conv.load.makeArticleId(null);
          fyre.conv.load({}, [ {
            el : 'livefyre-comments',
            network : "livefyre.com",
            siteId : "335643",
            articleId : articleId,
            signed : false,
            collectionMeta : {
              articleId : articleId,
              url : fyre.conv.load.makeCollectionUrl(),
            }
          } ], function() {
          });
        });
  }
}, 3000);
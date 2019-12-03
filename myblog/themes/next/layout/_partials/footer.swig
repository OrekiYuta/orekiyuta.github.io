<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.footer.icon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>

  {% if theme.post_wordcount.totalcount %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.post_wordcount.item_text %}
      <span class="post-meta-item-text">{{ __('post.totalcount') }}&#58;</span>
    {% endif %}
    <span title="{{ __('post.totalcount') }}">{#
    #}{{ totalcount(site, '0,0.0a') }}{#
  #}</span>
  {% endif %}
</div>

{% if theme.footer.powered %}
  <div class="powered-by">{#
  #}{{ __('footer.powered', '<a class="theme-link" target="_blank" href="https://hexo.io">Hexo</a>') }}{#
#}</div>
{% endif %}

{% if theme.footer.powered and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{% endif %}

{% if theme.footer.theme.enable %}
  <div class="theme-info">{#
  #}{{ __('footer.theme') }} &mdash; {#
  #}<a class="theme-link" target="_blank" href="https://github.com/iissnan/hexo-theme-next">{#
    #}NexT.{{ theme.scheme }}{#
  #}</a>{% if theme.footer.theme.version %} v{{ theme.version }}{% endif %}{#
#}</div>
{% endif %}

{% if theme.footer.custom_text %}
  <div class="footer-custom">{#
  #}{{ theme.footer.custom_text }}{#
#}</div>
{% endif %}

<!--访问数-->
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<!--添加网站的运行时间-->

<script language="javascript">
	function siteTime(){
		window.setTimeout("siteTime()", 1000);
		var seconds = 1000
		var minutes = seconds * 60
		var hours = minutes * 60
		var days = hours * 24
		var years = days * 365

		var today = new Date()
		var todayYear = today.getFullYear()
		var todayMonth = today.getMonth()
		var todayDate = today.getDate()
		var todayHour = today.getHours()
		var todayMinute = today.getMinutes()
		var todaySecond = today.getSeconds()
		var t1 = Date.UTC(2018,11,12,00,00,00)
		var t2 = Date.UTC(todayYear,todayMonth,todayDate,todayHour,todayMinute,todaySecond)
		var diff = t2-t1

		var diffYears = Math.floor(diff/years)
		var diffDays = Math.floor((diff/days)-diffYears*365)
		var diffHours = Math.floor((diff-(diffYears*365+diffDays)*days)/hours)
		var diffMinutes = Math.floor((diff-(diffYears*365+diffDays)*days-diffHours*hours)/minutes)
		var diffSeconds = Math.floor((diff-(diffYears*365+diffDays)*days-diffHours*hours-diffMinutes*minutes)/seconds)
		document.getElementById("sitetime").innerHTML=" Run -> "+diffYears+"Y : "+diffDays+"D : "+diffHours+"h : "+diffMinutes+"m : "+diffSeconds+"s"
	}
	siteTime()
</script>
<div>
  <i class="fa fa-cog fa-spin"></i>
  <span id="sitetime"></span>&nbsp;|&nbsp;
	<i class="fa fa-street-view"></i>
	<span id="busuanzi_container_site_uv">
	  Visitors:<span id="busuanzi_value_site_uv"></span>
	</span>&nbsp;|&nbsp;
	<i class="fa fa-eye"></i>
	<span id="busuanzi_container_site_pv">
	  Views:<span id="busuanzi_value_site_pv"></span>
	</span>
</div>
	



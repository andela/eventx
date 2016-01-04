/*!
 * Date picker for pickadate.js v3.5.0
 * http://amsul.github.io/pickadate.js/date.htm
 */
!function(e){"function"==typeof define&&define.amd?define(["picker","jquery"],e):"object"==typeof exports?module.exports=e(require("./picker.js"),require("jquery")):e(Picker,jQuery)}(function(e,t){function a(e,t){var a=this,n=e.$node[0],i=n.value,r=e.$node.data("value"),o=r||i,s=r?t.formatSubmit:t.format,l=function(){return n.currentStyle?"rtl"==n.currentStyle.direction:"rtl"==getComputedStyle(e.$root[0]).direction};a.settings=t,a.$node=e.$node,a.queue={min:"measure create",max:"measure create",now:"now create",select:"parse create validate",highlight:"parse navigate create validate",view:"parse create validate viewset",disable:"deactivate",enable:"activate"},a.item={},a.item.clear=null,a.item.disable=(t.disable||[]).slice(0),a.item.enable=-function(e){return e[0]===!0?e.shift():-1}(a.item.disable),a.set("min",t.min).set("max",t.max).set("now"),o?a.set("select",o,{format:s}):a.set("select",null).set("highlight",a.item.now),a.key={40:7,38:-7,39:function(){return l()?-1:1},37:function(){return l()?1:-1},go:function(e){var t=a.item.highlight,n=new Date(t.year,t.month,t.date+e);a.set("highlight",n,{interval:e}),this.render()}},e.on("render",function(){e.$root.find("."+t.klass.selectMonth).on("change",function(){var a=this.value;a&&(e.set("highlight",[e.get("view").year,a,e.get("highlight").date]),e.$root.find("."+t.klass.selectMonth).trigger("focus"))}),e.$root.find("."+t.klass.selectYear).on("change",function(){var a=this.value;a&&(e.set("highlight",[a,e.get("view").month,e.get("highlight").date]),e.$root.find("."+t.klass.selectYear).trigger("focus"))})},1).on("open",function(){var n="";a.disabled(a.get("now"))&&(n=":not(."+t.klass.buttonToday+")"),e.$root.find("button"+n+", select").attr("disabled",!1)},1).on("close",function(){e.$root.find("button, select").attr("disabled",!0)},1)}var n=7,i=6,r=e._;a.prototype.set=function(e,t,a){var n=this,i=n.item;return null===t?("clear"==e&&(e="select"),i[e]=t,n):(i["enable"==e?"disable":"flip"==e?"enable":e]=n.queue[e].split(" ").map(function(i){return t=n[i](e,t,a)}).pop(),"select"==e?n.set("highlight",i.select,a):"highlight"==e?n.set("view",i.highlight,a):e.match(/^(flip|min|max|disable|enable)$/)&&(i.select&&n.disabled(i.select)&&n.set("select",i.select,a),i.highlight&&n.disabled(i.highlight)&&n.set("highlight",i.highlight,a)),n)},a.prototype.get=function(e){return this.item[e]},a.prototype.create=function(e,a,n){var i,o=this;return a=void 0===a?e:a,a==-(1/0)||a==1/0?i=a:t.isPlainObject(a)&&r.isInteger(a.pick)?a=a.obj:t.isArray(a)?(a=new Date(a[0],a[1],a[2]),a=r.isDate(a)?a:o.create().obj):a=r.isInteger(a)||r.isDate(a)?o.normalize(new Date(a),n):o.now(e,a,n),{year:i||a.getFullYear(),month:i||a.getMonth(),date:i||a.getDate(),day:i||a.getDay(),obj:i||a,pick:i||a.getTime()}},a.prototype.createRange=function(e,a){var n=this,i=function(e){return e===!0||t.isArray(e)||r.isDate(e)?n.create(e):e};return r.isInteger(e)||(e=i(e)),r.isInteger(a)||(a=i(a)),r.isInteger(e)&&t.isPlainObject(a)?e=[a.year,a.month,a.date+e]:r.isInteger(a)&&t.isPlainObject(e)&&(a=[e.year,e.month,e.date+a]),{from:i(e),to:i(a)}},a.prototype.withinRange=function(e,t){return e=this.createRange(e.from,e.to),t.pick>=e.from.pick&&t.pick<=e.to.pick},a.prototype.overlapRanges=function(e,t){var a=this;return e=a.createRange(e.from,e.to),t=a.createRange(t.from,t.to),a.withinRange(e,t.from)||a.withinRange(e,t.to)||a.withinRange(t,e.from)||a.withinRange(t,e.to)},a.prototype.now=function(e,t,a){return t=new Date,a&&a.rel&&t.setDate(t.getDate()+a.rel),this.normalize(t,a)},a.prototype.navigate=function(e,a,n){var i,r,o,s,l=t.isArray(a),d=t.isPlainObject(a),c=this.item.view;if(l||d){for(d?(r=a.year,o=a.month,s=a.date):(r=+a[0],o=+a[1],s=+a[2]),n&&n.nav&&c&&c.month!==o&&(r=c.year,o=c.month),i=new Date(r,o+(n&&n.nav?n.nav:0),1),r=i.getFullYear(),o=i.getMonth();new Date(r,o,s).getMonth()!==o;)s-=1;a=[r,o,s]}return a},a.prototype.normalize=function(e){return e.setHours(0,0,0,0),e},a.prototype.measure=function(e,t){var a=this;return t?"string"==typeof t?t=a.parse(e,t):r.isInteger(t)&&(t=a.now(e,t,{rel:t})):t="min"==e?-(1/0):1/0,t},a.prototype.viewset=function(e,t){return this.create([t.year,t.month,1])},a.prototype.validate=function(e,a,n){var i,o,s,l,d=this,c=a,u=n&&n.interval?n.interval:1,h=-1===d.item.enable,y=d.item.min,m=d.item.max,p=h&&d.item.disable.filter(function(e){if(t.isArray(e)){var n=d.create(e).pick;n<a.pick?i=!0:n>a.pick&&(o=!0)}return r.isInteger(e)}).length;if((!n||!n.nav)&&(!h&&d.disabled(a)||h&&d.disabled(a)&&(p||i||o)||!h&&(a.pick<=y.pick||a.pick>=m.pick)))for(h&&!p&&(!o&&u>0||!i&&0>u)&&(u*=-1);d.disabled(a)&&(Math.abs(u)>1&&(a.month<c.month||a.month>c.month)&&(a=c,u=u>0?1:-1),a.pick<=y.pick?(s=!0,u=1,a=d.create([y.year,y.month,y.date+(a.pick===y.pick?0:-1)])):a.pick>=m.pick&&(l=!0,u=-1,a=d.create([m.year,m.month,m.date+(a.pick===m.pick?0:1)])),!s||!l);)a=d.create([a.year,a.month,a.date+u]);return a},a.prototype.disabled=function(e){var a=this,n=a.item.disable.filter(function(n){return r.isInteger(n)?e.day===(a.settings.firstDay?n:n-1)%7:t.isArray(n)||r.isDate(n)?e.pick===a.create(n).pick:t.isPlainObject(n)?a.withinRange(n,e):void 0});return n=n.length&&!n.filter(function(e){return t.isArray(e)&&"inverted"==e[3]||t.isPlainObject(e)&&e.inverted}).length,-1===a.item.enable?!n:n||e.pick<a.item.min.pick||e.pick>a.item.max.pick},a.prototype.parse=function(e,t,a){var n=this,i={};return t&&"string"==typeof t?(a&&a.format||(a=a||{},a.format=n.settings.format),n.formats.toArray(a.format).map(function(e){var a=n.formats[e],o=a?r.trigger(a,n,[t,i]):e.replace(/^!/,"").length;a&&(i[e]=t.substr(0,o)),t=t.substr(o)}),[i.yyyy||i.yy,+(i.mm||i.m)-1,i.dd||i.d]):t},a.prototype.formats=function(){function e(e,t,a){var n=e.match(/\w+/)[0];return a.mm||a.m||(a.m=t.indexOf(n)+1),n.length}function t(e){return e.match(/\w+/)[0].length}return{d:function(e,t){return e?r.digits(e):t.date},dd:function(e,t){return e?2:r.lead(t.date)},ddd:function(e,a){return e?t(e):this.settings.weekdaysShort[a.day]},dddd:function(e,a){return e?t(e):this.settings.weekdaysFull[a.day]},m:function(e,t){return e?r.digits(e):t.month+1},mm:function(e,t){return e?2:r.lead(t.month+1)},mmm:function(t,a){var n=this.settings.monthsShort;return t?e(t,n,a):n[a.month]},mmmm:function(t,a){var n=this.settings.monthsFull;return t?e(t,n,a):n[a.month]},yy:function(e,t){return e?2:(""+t.year).slice(2)},yyyy:function(e,t){return e?4:t.year},toArray:function(e){return e.split(/(d{1,4}|m{1,4}|y{4}|yy|!.)/g)},toString:function(e,t){var a=this;return a.formats.toArray(e).map(function(e){return r.trigger(a.formats[e],a,[0,t])||e.replace(/^!/,"")}).join("")}}}(),a.prototype.isDateExact=function(e,a){var n=this;return r.isInteger(e)&&r.isInteger(a)||"boolean"==typeof e&&"boolean"==typeof a?e===a:(r.isDate(e)||t.isArray(e))&&(r.isDate(a)||t.isArray(a))?n.create(e).pick===n.create(a).pick:t.isPlainObject(e)&&t.isPlainObject(a)?n.isDateExact(e.from,a.from)&&n.isDateExact(e.to,a.to):!1},a.prototype.isDateOverlap=function(e,a){var n=this,i=n.settings.firstDay?1:0;return r.isInteger(e)&&(r.isDate(a)||t.isArray(a))?(e=e%7+i,e===n.create(a).day+1):r.isInteger(a)&&(r.isDate(e)||t.isArray(e))?(a=a%7+i,a===n.create(e).day+1):t.isPlainObject(e)&&t.isPlainObject(a)?n.overlapRanges(e,a):!1},a.prototype.flipEnable=function(e){var t=this.item;t.enable=e||(-1==t.enable?1:-1)},a.prototype.deactivate=function(e,a){var n=this,i=n.item.disable.slice(0);return"flip"==a?n.flipEnable():a===!1?(n.flipEnable(1),i=[]):a===!0?(n.flipEnable(-1),i=[]):a.map(function(e){for(var a,o=0;o<i.length;o+=1)if(n.isDateExact(e,i[o])){a=!0;break}a||(r.isInteger(e)||r.isDate(e)||t.isArray(e)||t.isPlainObject(e)&&e.from&&e.to)&&i.push(e)}),i},a.prototype.activate=function(e,a){var n=this,i=n.item.disable,o=i.length;return"flip"==a?n.flipEnable():a===!0?(n.flipEnable(1),i=[]):a===!1?(n.flipEnable(-1),i=[]):a.map(function(e){var a,s,l,d;for(l=0;o>l;l+=1){if(s=i[l],n.isDateExact(s,e)){a=i[l]=null,d=!0;break}if(n.isDateOverlap(s,e)){t.isPlainObject(e)?(e.inverted=!0,a=e):t.isArray(e)?(a=e,a[3]||a.push("inverted")):r.isDate(e)&&(a=[e.getFullYear(),e.getMonth(),e.getDate(),"inverted"]);break}}if(a)for(l=0;o>l;l+=1)if(n.isDateExact(i[l],e)){i[l]=null;break}if(d)for(l=0;o>l;l+=1)if(n.isDateOverlap(i[l],e)){i[l]=null;break}a&&i.push(a)}),i.filter(function(e){return null!=e})},a.prototype.nodes=function(e){var t=this,a=t.settings,o=t.item,s=o.now,l=o.select,d=o.highlight,c=o.view,u=o.disable,h=o.min,y=o.max,m=function(e,t){return a.firstDay&&(e.push(e.shift()),t.push(t.shift())),r.node("thead",r.node("tr",r.group({min:0,max:n-1,i:1,node:"th",item:function(n){return[e[n],a.klass.weekdays,'scope=col title="'+t[n]+'"']}})))}((a.showWeekdaysFull?a.weekdaysFull:a.weekdaysLetter).slice(0),a.weekdaysFull.slice(0)),p=function(e){return r.node("div"," ",a.klass["nav"+(e?"Next":"Prev")]+(e&&c.year>=y.year&&c.month>=y.month||!e&&c.year<=h.year&&c.month<=h.month?" "+a.klass.navDisabled:""),"data-nav="+(e||-1)+" "+r.ariaAttr({role:"button",controls:t.$node[0].id+"_table"})+' title="'+(e?a.labelMonthNext:a.labelMonthPrev)+'"')},f=function(n){var i=a.showMonthsShort?a.monthsShort:a.monthsFull;return"short_months"==n&&(i=a.monthsShort),a.selectMonths&&void 0==n?r.node("select",r.group({min:0,max:11,i:1,node:"option",item:function(e){return[i[e],0,"value="+e+(c.month==e?" selected":"")+(c.year==h.year&&e<h.month||c.year==y.year&&e>y.month?" disabled":"")]}}),a.klass.selectMonth+" browser-default",(e?"":"disabled")+" "+r.ariaAttr({controls:t.$node[0].id+"_table"})+' title="'+a.labelMonthSelect+'"'):"short_months"==n?null!=l?r.node("div",i[l.month]):r.node("div",i[c.month]):r.node("div",i[c.month],a.klass.month)},g=function(n){var i=c.year,o=a.selectYears===!0?5:~~(a.selectYears/2);if(o){var s=h.year,l=y.year,d=i-o,u=i+o;if(s>d&&(u+=s-d,d=s),u>l){var m=d-s,p=u-l;d-=m>p?p:m,u=l}if(a.selectYears&&void 0==n)return r.node("select",r.group({min:d,max:u,i:1,node:"option",item:function(e){return[e,0,"value="+e+(i==e?" selected":"")]}}),a.klass.selectYear+" browser-default",(e?"":"disabled")+" "+r.ariaAttr({controls:t.$node[0].id+"_table"})+' title="'+a.labelYearSelect+'"')}return"raw"==n?r.node("div",i):r.node("div",i,a.klass.year)};return createDayLabel=function(){return null!=l?r.node("div",l.date):r.node("div",s.date)},createWeekdayLabel=function(){var e;e=null!=l?l.day:s.day;var t=a.weekdaysFull[e];return t},r.node("div",r.node("div",createWeekdayLabel(),"picker__weekday-display")+r.node("div",f("short_months"),a.klass.month_display)+r.node("div",createDayLabel(),a.klass.day_display)+r.node("div",g("raw"),a.klass.year_display),a.klass.date_display)+r.node("div",r.node("div",(a.selectYears?f()+g():f()+g())+p()+p(1),a.klass.header)+r.node("table",m+r.node("tbody",r.group({min:0,max:i-1,i:1,node:"tr",item:function(e){var i=a.firstDay&&0===t.create([c.year,c.month,1]).day?-7:0;return[r.group({min:n*e-c.day+i+1,max:function(){return this.min+n-1},i:1,node:"td",item:function(e){e=t.create([c.year,c.month,e+(a.firstDay?1:0)]);var n=l&&l.pick==e.pick,i=d&&d.pick==e.pick,o=u&&t.disabled(e)||e.pick<h.pick||e.pick>y.pick,m=r.trigger(t.formats.toString,t,[a.format,e]);return[r.node("div",e.date,function(t){return t.push(c.month==e.month?a.klass.infocus:a.klass.outfocus),s.pick==e.pick&&t.push(a.klass.now),n&&t.push(a.klass.selected),i&&t.push(a.klass.highlighted),o&&t.push(a.klass.disabled),t.join(" ")}([a.klass.day]),"data-pick="+e.pick+" "+r.ariaAttr({role:"gridcell",label:m,selected:n&&t.$node.val()===m?!0:null,activedescendant:i?!0:null,disabled:o?!0:null})),"",r.ariaAttr({role:"presentation"})]}})]}})),a.klass.table,'id="'+t.$node[0].id+'_table" '+r.ariaAttr({role:"grid",controls:t.$node[0].id,readonly:!0})),a.klass.calendar_container)+r.node("div",r.node("button",a.today,"btn-flat picker__today","type=button data-pick="+s.pick+(e&&!t.disabled(s)?"":" disabled")+" "+r.ariaAttr({controls:t.$node[0].id}))+r.node("button",a.clear,"btn-flat picker__clear","type=button data-clear=1"+(e?"":" disabled")+" "+r.ariaAttr({controls:t.$node[0].id}))+r.node("button",a.close,"btn-flat picker__close","type=button data-close=true "+(e?"":" disabled")+" "+r.ariaAttr({controls:t.$node[0].id})),a.klass.footer)},a.defaults=function(e){return{labelMonthNext:"Next month",labelMonthPrev:"Previous month",labelMonthSelect:"Select a month",labelYearSelect:"Select a year",monthsFull:["January","February","March","April","May","June","July","August","September","October","November","December"],monthsShort:["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],weekdaysFull:["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],weekdaysShort:["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],weekdaysLetter:["S","M","T","W","T","F","S"],today:"Today",clear:"Clear",close:"Close",format:"d mmmm, yyyy",klass:{table:e+"table",header:e+"header",date_display:e+"date-display",day_display:e+"day-display",month_display:e+"month-display",year_display:e+"year-display",calendar_container:e+"calendar-container",navPrev:e+"nav--prev",navNext:e+"nav--next",navDisabled:e+"nav--disabled",month:e+"month",year:e+"year",selectMonth:e+"select--month",selectYear:e+"select--year",weekdays:e+"weekday",day:e+"day",disabled:e+"day--disabled",selected:e+"day--selected",highlighted:e+"day--highlighted",now:e+"day--today",infocus:e+"day--infocus",outfocus:e+"day--outfocus",footer:e+"footer",buttonClear:e+"button--clear",buttonToday:e+"button--today",buttonClose:e+"button--close"}}}(e.klasses().picker+"__"),e.extend("pickadate",a)});
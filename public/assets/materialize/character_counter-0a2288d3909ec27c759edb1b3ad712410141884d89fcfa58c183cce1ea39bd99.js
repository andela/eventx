!function(t){function n(){var n=+t(this).attr("length"),a=+t(this).val().length,s=n>=a;t(this).parent().find('span[class="character-counter"]').html(a+"/"+n),i(s,t(this))}function a(n){var a=t("<span/>").addClass("character-counter").css("float","right").css("font-size","12px").css("height",1);n.parent().append(a)}function s(){t(this).parent().find('span[class="character-counter"]').html("")}function i(t,n){var a=n.hasClass("invalid");t&&a?n.removeClass("invalid"):t||a||(n.removeClass("valid"),n.addClass("invalid"))}t.fn.characterCounter=function(){return this.each(function(){var i=void 0!==t(this).attr("length");i&&(t(this).on("input",n),t(this).on("focus",n),t(this).on("blur",s),a(t(this)))})},t(document).ready(function(){t("input, textarea").characterCounter()})}(jQuery);
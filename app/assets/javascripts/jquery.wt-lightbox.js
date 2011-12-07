/**
 * jQuery Lightbox
 * Copyright (c) 2011 Allan Ma (http://codecanyon.net/user/webtako)
 * Version: 1.12 (09/29/2011)
 */
;(function($) {
	var OVERLAY_OPACITY = .75;
	var DEFAULT_DURATION = 600;
	var ANIMATE_SPEED = 300;
	var DEFAULT_DELAY = 4000;
	var LIGHTBOX_SIZE = 250;
	var LIGHTBOX_MARGIN = 40;
	var UPDATE_TEXT = "update_text";
	var START_TIMER = "start_timer";
	var IE6_INIT = 	  "ie6_init";
	var IE6_CLEANUP = "ie6_cleanup";
	var OPEN = "lightbox_open";
	var CLOSE = "lightbox_close";
	var CONTENT =  "<div id='overlay'></div>\
					<div id='lightbox'>\
						<div class='preloader'></div>\
						<div class='inner-box'>\
							<div class='content'></div>\
							<div class='timer'></div>\
							<div class='desc'><div class='inner-text'></div></div>\
							<div class='btn-panel'><div class='back-btn'></div></div>\
							<div class='btn-panel'><div class='fwd-btn'></div></div>\
						</div>\
						<div class='cpanel'>\
							<div id='play-btn'></div>\
							<div class='info'></div>\
							<div id='close-btn'></div>\
						</div>\
					</div>";
					
	var defaults = { 
		rotate:true,
		delay:DEFAULT_DELAY,
		easing:"",
		transition_speed:DEFAULT_DURATION,
		display_dbuttons:true,
		display_number:true,
		display_timer:true,
		display_caption:true,
		caption_align:"bottom",
		mouseover_buttons:true,
		cont_nav:true,
		auto_fit:true
	};
		
	var $overlay;
	var $lightbox;
	var $textPanel;
	var $preloader;
	var $cPanel;
	var $playButton;
	var $infoPanel;
	var $innerBox;
	var $backPane;
	var $backButton;
	var $fwdPane;
	var $fwdButton;
	var $timer;
	var $item;	
	var $currObj;
	var $currGroup;	
	var currIndex;		
	var numItems;	
	var contNav;
	var mouseoverBtns;
	var rotate;
	var padding;
	var timerId;
	
	$(document).ready(function() {
		initLightbox();
	});
	
	//constructor
	$.fn.wtLightBox = function(params) {
		var $obj = $(this);
		var opts = $.extend(true, {}, defaults, params);		
		$obj.data({rotate:opts.rotate, delay:getPosNumber(opts.delay, DEFAULT_DELAY), duration:getPosNumber(opts.transition_speed, DEFAULT_DURATION),
				   "displayTimer":opts.display_timer, "displayDButtons":opts.display_dbuttons, "displayNum":opts.display_number, "contNav":opts.cont_nav,
				   "displayText":opts.display_caption, "textAlign":opts.caption_align.toLowerCase(), "autoFit":opts.auto_fit, easing:opts.easing,
				   "mouseoverBtns":!window.Touch ? opts.mouseover_buttons : false})
			.each(function(n) {
					var $group;
					var index;
					var rel = $(this).attr("rel");
					if (rel && rel != "") {
						$group = $obj.filter("[rel="+rel+"]");
						index = $group.index($(this));
					}
					else {
						$group = $(this);
						index = 0;
					}
					$(this).bind("click", {index:index, group:$group, obj:$obj}, openLightbox);
				});
		
		return this;
	}
	
	//init lightbox
	var initLightbox = function() {
		timerId = null;
		
		$("body").append(CONTENT);
		$overlay = 	$("#overlay").click(closeLightbox);
		$lightbox =	 $("#lightbox");
		$preloader = $lightbox.find("div.preloader");	
		$innerBox =  $lightbox.find("div.inner-box");
		$timer =	 $innerBox.find("div.timer").data("pct", 1);
		$textPanel = $innerBox.find("div.desc");							
		$backButton = $innerBox.find(".back-btn");	
		$fwdButton = $innerBox.find(".fwd-btn");
		$backPane =  $innerBox.find("div.btn-panel").has($backButton);												
		$fwdPane =   $innerBox.find("div.btn-panel").has($fwdButton);
		$cPanel = 	 $lightbox.find("div.cpanel").bind("click", cpanelClick);				
		$playButton = $cPanel.find("#play-btn");
		$infoPanel = $cPanel.find(".info");	
		padding = $lightbox.outerWidth() - $lightbox.width();
		
		initMisc();
	}
	
	//open lightbox
	var openLightbox = function(e) {
		rotate = false;		
		$currObj = $(e.data.obj);
		$currGroup = $(e.data.group);
		currIndex = e.data.index;
		
		numItems = $currGroup.size();		
		contNav = $currObj.data("contNav");
		mouseoverBtns = $currObj.data("mouseoverBtns");
		var textAlign = $currObj.data("textAlign");
		var displayText = $currObj.data("displayText");
		var rotateOn;
		var displayTimer;
		var displayNum;
		var displayDButtons;
	
		if (numItems > 1) {
			rotateOn = $currObj.data("rotate");
			displayTimer = $currObj.data("displayTimer");
			displayDButtons = $currObj.data("displayDButtons");
			displayNum = $currObj.data("displayNum");
		}
		else { 
			rotateOn = displayTimer = displayDButtons = displayNum = false;
		}
		
		if (rotateOn) {			
			$lightbox.bind(START_TIMER, startTimer);
			$playButton.toggleClass("pause", rotate).show();			
		}
		else {
			$lightbox.unbind(START_TIMER);			
			$playButton.hide();
		}	
		
		if (displayTimer) {
			$timer.css(textAlign == "top" ? "bottom" : "top", 0).css("visibility","visible");
		}
		else {
			$timer.css({visibility:"hidden"});
		}
		
		if (displayDButtons) {
			$backPane.css("visibility","visible");
			$fwdPane.css("visibility","visible");
		}
		else {
			$backPane.css("visibility","hidden");
			$fwdPane.css("visibility","hidden");					
		}
		
		if (displayNum) {
			$infoPanel.css("visibility","visible");
		}
		else {
			$infoPanel.css("visibility","hidden");
		}
		
		if (displayText) {
			$lightbox.unbind(UPDATE_TEXT).bind(UPDATE_TEXT, updateText);
			$textPanel.show();
		}
		else {
			$lightbox.unbind(UPDATE_TEXT);
			$textPanel.hide();
		}
		
		if (!mouseoverBtns) {
			$backButton.css("margin-left", 0);
			$fwdButton.css("margin-left", -$fwdButton.width());
		}
		
		$lightbox.data("visible", true).trigger(IE6_INIT);
		$(document).unbind("keyup", keyClose).bind("keyup", keyClose);
		$overlay.stop(true,true).css("opacity",OVERLAY_OPACITY).show();
		$lightbox.css({width:LIGHTBOX_SIZE, height:LIGHTBOX_SIZE, "margin-left":-LIGHTBOX_SIZE/2, "margin-top":-LIGHTBOX_SIZE/2}).show();								   
		loadContent(currIndex);
		$(document).trigger(OPEN);
		
		return false;
	}
	
	//close lightbox 
	var closeLightbox = function() {
		resetTimer();			
		$lightbox.data("visible", false).trigger(IE6_CLEANUP);
		$(document).unbind("keyup", keyClose).unbind("keyup", keyCtrl);
		disableCtrl();
		$textPanel.stop(true).hide();
		$lightbox.stop(true).hide();
		$overlay.stop(true).fadeOut("fast");
		$(document).trigger(CLOSE);
		
		return false;
	}
	
	//load content
	var loadContent = function(i) {
		$item = $($currGroup.get(i));
		disableCtrl();
		$textPanel.stop(true).hide();
		
		var $img = $("<img/>");
		$("div.content", $innerBox).empty().append($img);
		$img.css({opacity:0, visibility:"hidden"})
			.load(
				function() {
					$preloader.hide();	
					displayContent($img);
				}
			);
		
		$img.attr("src", $item.attr("href"));
		if ($img[0].complete || $img[0].readyState == "complete") {
			$img.unbind("load");
			$preloader.hide();
			displayContent($img);					
		}
		else {
			$preloader.show();
		}
	}
	
	//display content
	var displayContent = function($img) {
		if ($lightbox.data("visible")) {							
			if ($currObj.data("autoFit")) {
				resizeImg($img[0]);
			}
			var width  = $img[0].width;
			var innerHeight = $img[0].height;
			var outerHeight = innerHeight + $cPanel.height();
			var newDuration = getDuration(width, outerHeight);
			var marginLeft =  -(width + padding)/2;
			var marginTop = -(outerHeight + (padding/2))/2;					
			$lightbox.stop(true).animate({"margin-left":marginLeft, "margin-top":marginTop, width:width, height:outerHeight}, newDuration, $currObj.data("easing"), 
					function() {
						$innerBox.height(innerHeight);
						$infoPanel.html((currIndex + 1) + " / " + numItems);							
						$lightbox.trigger(UPDATE_TEXT);
						enableCtrl();
						$img.css("visibility", "visible").animate({opacity:1}, "normal", 
								function() {
									if (jQuery.browser.msie) { 
										this.style.removeAttribute('filter'); 
									}											
									$lightbox.trigger(START_TIMER);
								});									
					}
			);
		}
	}
	
	//display text panel
	var updateText = function() {
		var text = $item.attr("title");
		if (!text || text == "") {
			text = $item.data("text");
		}
		if (text && text != "") {
			$textPanel.find("div.inner-text").html(text);
			var textAlign = $currObj.data("textAlign");
			$textPanel.stop().css("top", textAlign == "bottom" ? $innerBox.height() : -$textPanel.height()).show()
					  .animate({top:textAlign == "bottom" ? $innerBox.height() - $textPanel.height() : 0}, "normal");
		}				
	}
	
	//resize image
	var resizeImg = function(img) {
		var ratio;
		var maxWidth  = $(window).width() - padding - LIGHTBOX_MARGIN;
		var maxHeight = $(window).height() - padding/2 - $cPanel.height() - LIGHTBOX_MARGIN;
		
		if (img.width > maxWidth) {
			ratio = img.height/img.width;
			img.width = maxWidth;
			img.height = ratio * maxWidth;
		}
		if (img.height > maxHeight) {
			ratio = img.width/img.height;
			img.width = ratio * maxHeight;
			img.height = maxHeight;
		}
	}
	
	//enable control panel
	var enableCtrl = function() {
		$(document).unbind("keyup", keyCtrl).bind("keyup", keyCtrl);
		$cPanel.show();
		
		var backWidth = Math.round($innerBox.width()/2);				
		$backPane.css({width:backWidth, height:"100%"}).unbind();
		if	(!contNav && currIndex == 0) {
			$backPane.css("cursor","default");
		}
		else { 				
			$backPane.bind("click", prevImg).css("cursor","pointer");					
			$backButton.show();
		}
	
		var fwdWidth = $innerBox.width() - $backPane.width();
		$fwdPane.css({width:fwdWidth, height:"100%"}).unbind();
		if (!contNav && currIndex == numItems - 1) {
			$fwdPane.css("cursor","default");
		}
		else {
			$fwdPane.bind("click", nextImg).css("cursor","pointer");					
			$fwdButton.show();					
		}
		
		if (mouseoverBtns) {
			$backPane.hover(showPrevButton, hidePrevButton);
			$fwdPane.hover(showNextButton, hideNextButton);
		}
	}

	//disable control panel
	var disableCtrl = function() {
		$(document).unbind("keyup", keyCtrl);
		$cPanel.hide();
		$backButton.hide();
		$fwdButton.hide();
	}
	
	//control panel click
	var cpanelClick = function(e) {
		switch($(e.target).attr("id")) {
			case "play-btn":
				togglePlay();
				break;
			case "close-btn":
				closeLightbox();
				break;
		}
	}
	
	//play/pause
	var togglePlay = function() {
		rotate = !rotate;
		$playButton.toggleClass("pause", rotate);
		rotate ? $lightbox.trigger(START_TIMER) : pauseTimer();
		
		return false;
	}

	//previous
	var prevImg = function() {
		if ($backPane.css("visibility") == "visible") {
			resetTimer();
			if (currIndex > 0) {
				currIndex--;
			}
			else if (contNav) {
				currIndex = numItems - 1;
			}
			else {
				return;
			}				
			loadContent(currIndex);
		}
		
		return false;
	}
	
	//next
	var nextImg = function() {
		if ($fwdPane.css("visibility") == "visible") {
			resetTimer();
			if (currIndex < numItems - 1) {
				currIndex++;
			}
			else if (contNav) {
				currIndex = 0;
			}
			else {
				return;
			}				
			loadContent(currIndex);
		}
		
		return false;
	}

	//rotate next
	var rotateNext = function() {
		resetTimer();
		currIndex = (currIndex < numItems - 1) ? currIndex + 1 : 0;
		loadContent(currIndex);
	}
	
	//show previous button
	var showPrevButton = function() {
		$backButton.stop().animate({"margin-left":0}, ANIMATE_SPEED);
	}
	
	//hide previous button
	var hidePrevButton = function() {
		$backButton.stop().animate({"margin-left":-$backButton.width()}, ANIMATE_SPEED);
	}
	
	//show next button
	var showNextButton = function() {			
		$fwdButton.stop().animate({"margin-left":-$fwdButton.width()}, ANIMATE_SPEED);
	}
	
	//hide next button
	var hideNextButton = function() {
		$fwdButton.stop().animate({"margin-left":0}, ANIMATE_SPEED);
	}
	
	//key press
	var keyCtrl = function(e) {
		switch(e.keyCode) {
			case 37:
			case 80:
				prevImg();
				break;
			case 39:
			case 78:
				nextImg();
				break;
			case 32:
				togglePlay();
				break;
		}
	}
	
	//key press close
	var keyClose = function(e) {
		switch(e.keyCode) {
			case 27: case 67: case 88:
				closeLightbox();
		}
	}
	
	//get duration
	var getDuration = function(width, height) {
		var wDiff = Math.abs($lightbox.width() - width);
		var hDiff = Math.abs($lightbox.height() - height);
		return Math.max($currObj.data("duration"), wDiff, hDiff);
	}
	
	var initMisc = function() {
		if (jQuery.browser.msie && parseInt(jQuery.browser.version) <= 6) {
			var winWidth, winHeight;
			$overlay.css({position:"absolute", width:$(document).width(), height:$(document).height()});
			$lightbox.css("position", "absolute");
			$(window).bind("resize", 
						   function() {  
								if(winHeight != document.documentElement.clientHeight || winWidth != document.documentElement.clientWidth) {
									$overlay.css({width:$(document).width(), height:$(document).height()});
								}
								winWidth =  document.documentElement.clientWidth;
								winHeight = document.documentElement.clientHeight; 
							});	  
			$lightbox.bind(IE6_INIT, function() { $("body").find("select").addClass("hide-selects"); })
					 .bind(IE6_CLEANUP, function() { $("body").find("select").removeClass("hide-selects"); });									 
		}
		else if (window.Touch) {
			$overlay.css({width:$(document).width(), height:$(document).height()});
			$(window).bind("resize", function() { $overlay.css({width:$(document).width(), height:$(document).height()}); });	  
		}
	}
	
	//start timer
	var startTimer = function() {
		if (rotate && timerId == null) {
			var newDelay = Math.round($timer.data("pct") * $currObj.data("delay"));
			$timer.animate({width:$innerBox.width()+1}, newDelay, "linear");
			timerId = setTimeout(rotateNext, newDelay);
		}
	}
	
	//reset timer
	var resetTimer = function() {
		clearTimeout(timerId);
		timerId = null;
		$timer.stop(true).width(0).data("pct", 1);
	}
	
	//pause timer
	var pauseTimer = function() {
		clearTimeout(timerId);
		timerId = null;
		var pct = 1 - ($timer.width()/($innerBox.width()+1));
		$timer.stop(true).data("pct", pct);
	}
	
	//get positive number
	var getPosNumber = function(val, defaultVal) {
		if (!isNaN(val) && val > 0) {
			return val;
		}
		return defaultVal;
	}
})(jQuery);
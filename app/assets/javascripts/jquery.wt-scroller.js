/**
 * jQuery Image Scroller
 * Copyright (c) 2011 Allan Ma (http://codecanyon.net/user/webtako)
 * Version: 1.32 (09/29/2011)
 */
;(function($) {
	$.fn.wtScroller = function(params) {		
		var TOP = "top";
		var BOTTOM = "bottom";
		var OUTSIDE = "outside";
		var INSIDE = "inside";
		var SLIDE_OPACITY = 0.85;		
		var BUTTON_OPACITY = 0.7;
		var SCROLL_SPEED = 1000;
		var DEFAULT_DURATION = 600;
		var ANIMATE_SPEED = 300;
		var DEFAULT_DELAY = 4000;
		var UPDATE_BUTTONS ="update_buttons";
		var UPDATE_THUMB = 	"update_thumb";
		var UPDATE_INDEX = 	"update_index";
		var UPDATE_TEXT =	"update_text";
		var START_TIMER = 	"start_timer";
		var LB_OPEN = "lightbox_open";
		var LB_CLOSE = "lightbox_close";
		
		//Class Scroller
		function Scroller($obj, opts) {
			var numDisplay = 		getPosNumber(opts.num_display,3);
			var slideWidth = 		getPosNumber(opts.slide_width,300);
			var slideHeight = 		getPosNumber(opts.slide_height,200);
			var slideMargin = 		getNonNegNumber(opts.slide_margin,1);
			var margin = 			getNonNegNumber(opts.margin,10);
			var buttonWidth =		getPosNumber(opts.button_width,35);
			var ctrlHeight =		getPosNumber(opts.ctrl_height,20);
			var autoScroll = 		opts.auto_scroll;
			var delay = 			getPosNumber(opts.delay,DEFAULT_DELAY);
			var duration = 			getPosNumber(opts.scroll_speed,SCROLL_SPEED);
			var easing = 			opts.easing;
			var autoScale =			opts.auto_scale;
			var displayButtons = 	opts.display_buttons;
			var mouseoverButtons =  opts.mouseover_buttons;
			var ctrlType =			opts.ctrl_type.toLowerCase();
			var displayCaption = 	opts.display_caption;
			var mouseoverCaption = 	opts.mouseover_caption;
			var captionPos = 		opts.caption_position.toLowerCase();
			var captionAlign = 		opts.caption_align.toLowerCase();
			var moveBy1 = 			opts.move_one;
			var contNav = 			opts.cont_nav;
			var shuffle =			opts.shuffle;
			
			var $scroller;
			var $slidePanel;
			var $slideList;
			var $slides;
			var $prevBtn;			
			var $nextBtn;
			var $cbar;
			var $indexes;			
			var $scrollbar;
			var $thumb;
			var $items;
			
			var numItems;
			var unitSize;
			var prevSlots;
			var nextSlots;
			var maxSlots;	
			var range;
			var pos;	
			var timerId;
			var extOffset;
			var extHeight;
			var prevPct;
			
			this.init = function() {
				$scroller =   $(".wt-scroller", $obj);
				$slidePanel = $scroller.find(".slides");
				$slideList =  $slidePanel.find(">ul:first");
				$slides =	  $slideList.find(">li");
				$cbar = 	  $scroller.find(".lower-panel");
				$prevBtn =    $scroller.find(".prev-btn");			
				$nextBtn =    $scroller.find(".next-btn");
				extOffset = 0;
				extHeight = 0;
				pos = 0;
				prevPct = -1;
				timerId = null;
				numItems = $slides.size();
				if (numItems <= numDisplay) {
					displayButtons = false;
					ctrlType = "none";
					numDisplay = numItems;
				}
				if (ctrlType == "index") {
					moveBy1 = false;
				}
				
				//init components
				initItems();
				initSlidePanel();
				initCtrls();
				
				$scroller.css({width:$slidePanel.width() + $prevBtn.width() + $nextBtn.width(), height:$slidePanel.height() + $cbar.outerHeight(), "padding-top": margin});
				
				if (shuffle) {
					shuffleItems();
				}
				updateCPanel();
				$(document).bind(LB_CLOSE, onFocus).bind(LB_OPEN, onBlur);
				$scroller.trigger(LB_CLOSE);
			}
			
			//init slides
			var initItems = function() {
				initCaptions();
				$items = new Array(numItems);
				$slides.each(
					function(n) {						
						var $img = $(this).find("img:first");
						var $link = $(this).find(">a:first");
						if (!$link.attr("href")) {
							$(this).click(preventDefault);
							$link.css("cursor", "default");
						}
						else {
							$link.data("text",$(this).find(">p:first").html());
						}
						if (autoScale) {
							$img[0].complete || $img[0].readyState == "complete" ? processImg($img) : $img.load(processLoadedImg);
						}
						if (displayCaption && captionPos == INSIDE) {
							initCaption($(this));						
						}
						$items[n] = $(this);						
					});		
			}
			
			//init captions
			var initCaptions = function() {
				var $captions = $slides.find(">p:first");
				if (displayCaption) {
					var padding = $captions.outerWidth() - $captions.width();
					$captions.css({width:slideWidth - padding, visibility:"visible"}).click(preventDefault);
					if (captionPos == OUTSIDE) {
						var heights = $captions.map(function() { return $(this).height(); }).get();
						var maxHeight = Math.max.apply(Math, heights);					
						$captions.css({top:captionAlign == TOP ? 0 : slideHeight, height:maxHeight});
						
						extHeight = $captions.outerHeight();					
						if (captionAlign == TOP) {
							extOffset = extHeight;
						}
						$captions.addClass("outside");
					}
					else {
						$captions.addClass("inside");
					}					
				}
				else {
					$captions.hide();
				}
			}
			
			//init caption
			var initCaption = function($item) {
				var $caption = $item.find(">p:first");				
				if ($caption.length < 1 || $caption.html() == "") {
					$caption.remove();
					return;
				}
				if (mouseoverCaption) {
					$caption.css("top", captionAlign == TOP ? -$caption.outerHeight() : slideHeight);
					$item.hover(showCaption, hideCaption);
				}
				else {
					$caption.css("top", captionAlign == TOP ? 0 : slideHeight - $caption.outerHeight());
				}
			}
			
			//init slide panel
			var initSlidePanel = function() {
				$slides.css({width:slideWidth, height:slideHeight + extHeight, "margin-right":slideMargin}).hover(itemMouseover, itemMouseout);
				$slidePanel.css({width:(numDisplay * $slides.width()) + ((numDisplay - 1) * slideMargin), height:$slides.height()});
				unitSize = $slides.outerWidth(true);
				var num;
				if (ctrlType == "index") {
					num = numDisplay * Math.ceil(numItems/numDisplay);
				}
				else {
					num = numItems;
				}
				$slideList.width(num * unitSize);
				maxSlots = num - numDisplay;
				prevSlots = 0;
				nextSlots = maxSlots;
					
				range = (($slideList.width() - slideMargin) - $slidePanel.width());
			}
			
			var initCtrls = function() {
				initButtons();
				$cbar.css({width:$slidePanel.width(), "padding-left":$prevBtn.width(), "padding-right":$nextBtn.width()});
				switch(ctrlType) {
					case "scrollbar":
						initScrollbar();
						var ctrlMargin = Math.max((ctrlHeight - $scrollbar.height())/2, 0);
						$cbar.css({"padding-top":ctrlMargin, "padding-bottom":ctrlMargin});
						break;
					case "index":
						initIndexes();
						var ctrlMargin = Math.max((ctrlHeight - $indexes.height())/2, 0);
						$cbar.css({"padding-top":ctrlMargin, "padding-bottom":ctrlMargin});
						break;
					default:
						$cbar.remove();
						$scroller.css("padding-bottom", margin);
				}				
			}
			
			//init buttons
			var initButtons = function() {							
				if (displayButtons) {
					if (mouseoverButtons) {
						removeButtons();
						
						$slidePanel.append("<div class='m-prev'></div><div class='m-next'></div>");
						var $mPrev = $slidePanel.find(".m-prev").mousedown(preventDefault).click(moveBack);						
						var $mNext = $slidePanel.find(".m-next").mousedown(preventDefault).click(moveFwd);
						if (!window.Touch) {
							$mPrev.css("left", -$mPrev.width());
							$mNext.css("marginLeft", 0);
							
							$slidePanel.hover(
										function() {
											$mPrev.stop(true).animate({left:0}, ANIMATE_SPEED);	
											$mNext.stop(true).animate({marginLeft:-$mNext.width()}, ANIMATE_SPEED);	
										}, 
										function() {
											$mPrev.stop(true).animate({left:-$mPrev.width()}, ANIMATE_SPEED);	
											$mNext.stop(true).animate({marginLeft:0}, ANIMATE_SPEED);	
										});
						}
						
						if (!contNav) {
							$scroller.bind(UPDATE_BUTTONS, function() {
								var begIndex = Math.abs(pos/unitSize);
								var endIndex = begIndex + numDisplay;
								$mPrev.css(begIndex > 0 ? {opacity:1, cursor:"pointer"} : {opacity:0, cursor:"default"});
								$mNext.css(endIndex < numItems ? {opacity:1, cursor:"pointer"} : {opacity:0, cursor:"default"});
							});
						}
					}
					else {
						$prevBtn.css({width:buttonWidth, height:$slidePanel.height()}).mousedown(preventDefault).click(moveBack);
						$nextBtn.css({width:buttonWidth, height:$slidePanel.height()}).mousedown(preventDefault).click(moveFwd);
						if (!contNav) {
							$scroller.bind(UPDATE_BUTTONS, updateButtons);
						}
					}					
				}
				else {
					removeButtons();
				}
			}
			
			//remove main buttons
			var removeButtons = function() {
				$prevBtn.remove();
				$nextBtn.remove();
				$scroller.css({"padding-left":margin, "padding-right":margin});
			}
			
			//update buttons
			var updateButtons = function() {
				var begIndex = Math.abs(pos/unitSize);
				var endIndex = begIndex + numDisplay;
				$prevBtn.css(begIndex > 0 ? {opacity:1, cursor:"pointer"} : {opacity:BUTTON_OPACITY, cursor:"default"});
				$nextBtn.css(endIndex < numItems ? {opacity:1, cursor:"pointer"} : {opacity:BUTTON_OPACITY, cursor:"default"});
			}
			
			//init scrollbar
			var initScrollbar = function() {				
				$cbar.append("<div class='scroll-bar'><div class='thumb'></div></div>");
				$scrollbar = $cbar.find("div.scroll-bar");
				$thumb = 	 $cbar.find("div.thumb");				
				$scrollbar.width($cbar.width()).click(trackClick).mousedown(preventDefault);				
				$thumb.width(Math.ceil((numDisplay/numItems) * $scrollbar.width())).click(preventDefault);

				var scrollRange = $scrollbar.width() - $thumb.width();
				var moveRatio = range/scrollRange;
				try {
					$thumb.draggable({containment: "parent"})
						  .bind("drag", function() { $slideList.css({left: Math.round(-$thumb.position().left * moveRatio)}); })
						  .bind("dragstop", function() { autoStop($thumb.position().left/scrollRange); });
				}
				catch (ex) { //not draggable. 
				}
				
				$scroller.bind(UPDATE_THUMB, 
							   	function() {
									var move = Math.round(Math.abs(pos)/moveRatio);				
									$thumb.stop(true, true).animate({left:move}, duration, easing);
								});
			}
			
			//init indexes
			var initIndexes = function() {
				var n = Math.ceil(numItems/numDisplay);
				var str = "";
				for (var i = 0; i < n; i++) {
					str += "<span class='index'></span>";
				}
				$cbar.prepend(str);
				$indexes = $cbar.find(".index").mousedown(preventDefault).bind("click", goToIndex);
				$scroller.bind(UPDATE_INDEX, updateIndexes);				
			}
				
			//update indexes
			var updateIndexes = function() {
				var i = Math.ceil(prevSlots/numDisplay);
				$indexes.filter(".index-hl").removeClass("index-hl");
				$indexes.eq(i).addClass("index-hl");
			}
			
			//update slide list
			var updateSlideList = function() {
				pos = -prevSlots * unitSize;
				$slideList.stop(true, true).animate({left:pos}, duration, easing, 
															function() { 
																$scroller.trigger(START_TIMER); 
															});
				updateCPanel();
			}
			
			//update controls
			var updateCPanel = function() {
				$scroller.trigger(UPDATE_BUTTONS).trigger(UPDATE_THUMB).trigger(UPDATE_INDEX);					
			}
			
			//track click
			var trackClick = function(e) {
				autoStop((e.pageX - $scrollbar.offset().left)/$scrollbar.width());
			}
			
			//auto stop
			var autoStop = function(pct) {
				if (pct != prevPct) {
					prevPct = pct;
					var move;
					var newPos = pct * range;
					if (newPos > Math.abs(pos)) {
						move = Math.ceil(newPos/unitSize);			
					}
					else if (newPos < Math.abs(pos)) {
						move = Math.floor(newPos/unitSize);
					}
					else {
						return;
					}
					var slots = move + (pos/unitSize);			
					prevSlots += slots;
					nextSlots -= slots;
					updateSlideList();
				}
			}
			
			//go to index			
			var goToIndex = function() {
				stopTimer();
				prevSlots = $(this).index() * numDisplay;
				nextSlots = maxSlots - prevSlots;
				updateSlideList();
				return false;
			}
			
			//move slides back
			var moveBack = function() {
				stopTimer();
				if (nextSlots < maxSlots) {
					var slots = moveBy1 ? 1 : Math.min(maxSlots - nextSlots, numDisplay);
					nextSlots += slots;
					prevSlots -= slots;
				}
				else if (contNav) {
					nextSlots = 0;
					prevSlots = maxSlots;
				}
				else {
					return;
				}
				updateSlideList();
			}
			
			//move slides forward
			var moveFwd = function() {
				stopTimer();
				if (prevSlots < maxSlots) {
					var slots = moveBy1 ? 1 : Math.min(maxSlots - prevSlots, numDisplay);
					prevSlots += slots;
					nextSlots -= slots;
				}
				else if (contNav) {
					prevSlots = 0;
					nextSlots = maxSlots;		
				}
				else {
					return;
				}
				updateSlideList();
			}
			
			//rotate slides forward
			var rotateFwd = function() {
				stopTimer();
				if (prevSlots < maxSlots) {
					var slots = moveBy1 ? 1 : Math.min(maxSlots - prevSlots, numDisplay);
					prevSlots += slots;
					nextSlots -= slots;					
				}
				else {
					prevSlots = 0;
					nextSlots = maxSlots;		
				}
				updateSlideList();
			}
			
			//process loaded image size & position
			var processLoadedImg = function() {
				processImg($(this));
			}
			
			//process image
			var processImg = function($img) {
				if ($img.outerWidth() > 0 && $img.outerHeight() > 0) {
					var sizeRatio;
					if ($img.outerWidth() > slideWidth) {
						sizeRatio = $img.outerHeight()/$img.outerWidth();
						$img.css({width:slideWidth, height:sizeRatio * slideWidth});
					}
					if ($img.outerHeight() > slideHeight) {
						sizeRatio = $img.outerWidth()/$img.outerHeight();
						$img.css({width:sizeRatio * slideHeight, height:slideHeight});
					}
					$img.css({left:Math.round((slideWidth - $img.outerWidth())/2), top:extOffset + Math.round((slideHeight - $img.outerHeight())/2)});
				}
			}
			
			//scroller blur
			var onBlur = function() {
				$scroller.unbind(START_TIMER).unbind("mouseenter").unbind("mouseleave");
				stopTimer();
				$(document).unbind("keyup", onScrollKeyPress);
			}
			
			//scroller focus
			var onFocus = function() {
				if (autoScroll) {
					$scroller.bind(START_TIMER, startTimer).hover(scrollerOver, scrollerOut).trigger(START_TIMER);
				}
				$(document).bind("keyup", onScrollKeyPress);
			}
			
			//item mouseover
			var itemMouseover = function() {
				$(this).find("img:first").stop().animate({opacity:SLIDE_OPACITY}, ANIMATE_SPEED);				
			}
			
			//item mouseout
			var itemMouseout = function() {
				$(this).find("img:first").stop().animate({opacity:1}, ANIMATE_SPEED, 
					function() {
						if (jQuery.browser.msie) {
							this.style.removeAttribute('filter');						
						}
					});
			}
			
			//show caption
			var showCaption = function() {
				var $caption = $(this).find(">p:first");
				$caption.stop().animate({top:captionAlign == BOTTOM ? slideHeight - $caption.outerHeight() : 0}, ANIMATE_SPEED);
			}
			
			//hide caption
			var hideCaption = function() {
				var $caption = $(this).find(">p:first"); 
				$caption.stop().animate({top:captionAlign == BOTTOM ? slideHeight : -$caption.outerHeight()}, ANIMATE_SPEED);
			}
			
			//scroller over
			var scrollerOver = function() {
				$scroller.unbind(START_TIMER);
				stopTimer();
			}
			
			//scroller out
			var scrollerOut = function() {
				$scroller.bind(START_TIMER, startTimer).trigger(START_TIMER);
			}
			
			//key press
			var onScrollKeyPress = function(e) {
				switch(e.keyCode) {
					case 37:
						moveBack();
						break;
					case 39:
						moveFwd();
						break;
				}
			}
			
			//prevent default behavior
			var preventDefault = function() {
				return false;
			}
			
			//shuffle items
			var shuffleItems = function() {		
				for (var i = 0; i < $items.length; i++) {
					var ri = Math.floor(Math.random() * $items.length);
					var temp = $items[i];	
					$items[i] = $items[ri];
					$items[ri] = temp;				
				}
				
				for (var i = 0; i < $items.length; i++) {
					$items[i] = $items[i].clone(true);
				}
				
				for (var i = 0; i < $items.length; i++) {
					$slides.eq(i).replaceWith($items[i]);
				}
			}
			
			//start timer
			var startTimer = function() {
				if (timerId == null) {
					timerId = setTimeout(rotateFwd, delay);
				}
			}
			
			//stop timer
			var stopTimer = function() {
				clearTimeout(timerId);
				timerId = null;
			}
		}
		
		//get positive number
		var getPosNumber = function(val, defaultVal) {
			if (!isNaN(val) && val > 0) {
				return val;
			}
			return defaultVal;
		}
		
		//get nonnegative number
		var getNonNegNumber = function(val, defaultVal) {
			if (!isNaN(val) && val >= 0) {
				return val;
			}
			return defaultVal;
		}
		
		var defaults = { 
			num_display:3,
			slide_width:300,
			slide_height:200,
			slide_margin:1,
			button_width:35,
			ctrl_height:20,
			margin:10,	
			auto_scroll:true,
			delay:DEFAULT_DELAY,
			scroll_speed:SCROLL_SPEED,
			easing:"",
			auto_scale:true,
			move_one:false,
			ctrl_type:"scrollbar",
			display_buttons:true,
			mouseover_buttons:false,
			display_caption:true,
			mouseover_caption:false,
			caption_align:BOTTOM,
			caption_position:INSIDE,
			cont_nav:true,
			shuffle:false
		};
		
		var opts = $.extend(true, {}, defaults, params);		
		return this.each(
			function() {
				var scroller = new Scroller($(this), opts);
				scroller.init();
			}
		);
	}
})(jQuery);
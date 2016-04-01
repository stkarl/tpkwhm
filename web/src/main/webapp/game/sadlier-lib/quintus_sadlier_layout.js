/*global Quintus:false, module:false */


/**
Quintus HTML5 Game Engine - UI Module

The code in `quintus_ui.js` defines the `Quintus.UI` module, which
adds in some easily accessible UI elements into Quintus.

Depends on the `Quintus.Sprite` module.

UI lets you create UI elements like containers, buttons and text elements.

@module Quintus.UI
*/

var quintusSadlierLayout = function(Quintus) {
"use strict";

/**
 * Quintus UI Module Class
 *
 * @class Quintus.UI
 */
Quintus.SadlierLayout = function(Q) {
  if(Q._isUndefined(Quintus.UI)) {
    throw "Quintus.SadlierLayout requires Quintus.Touch Module";
  }

  Q.SadlierLayout = {};

  

  Q.SadlierLayout.VerticalLayout = Q.Sprite.extend("SadlierLayout.VerticalLayout",{


    init: function(p) {
      this.children = [];
      this._super(p, { type: 0 });
      this.fill = 'grey';
        this.p.color = 'grey';
    },

    insert: function(sprite) {
      this.stage.insert(sprite,this);
      this.relayout();
      // Bind to destroy
      return sprite;
    },

    relayout: function() {
      var totalHeight = 0;
      for(var i=0;i<this.children.length;i++) {
        totalHeight += this.children[i].p.h || 0;
      }

      // Center?
      var totalSepartion = this.p.h - totalHeight;

      var startY = -this.p.h/2;
      var yStep = totalSepartion / this.children.length;
      if (yStep < 25) {
          yStep = 25;
      }
      for(var i=0; i<this.children.length; i++) {
          if (i == 0) {
              this.children[i].p.y = startY + this.children[i].p.h/2 + yStep;
          } else {
              this.children[i].p.y =  this.children[i-1].p.y + this.children[i-1].p.h/2 + yStep;
          }
      }

      // Make sure all elements have the same space between them
    }
  });


Q.SadlierLayout.HorizontalLayout = Q.Sprite.extend("SadlierLayout.HorizontalLayout",{


    init: function(p) {
      this.children = [];
      this._super(p, { type: 0 });
    },

    insert: function(sprite) {
      this.stage.insert(sprite,this);
      this.relayout();
      // Bind to destroy
      return sprite;
    },

    relayout: function() {
      var totalWidth = 0;
      for(var i=0;i<this.children.length;i++) {
        totalWidth += this.children[i].p.w || 0;
      }

      // Center?
      var totalSepartion = this.p.w - totalWidth;

      var startX = -this.p.w/2;
      var xStep = totalSepartion/this.children.length;

      var lengthI = startX;
      for(var i=0;i<this.children.length;i++) {
        this.children[i].p.x = lengthI + this.children[i].p.w/2;
	 lengthI = lengthI + this.children[i].p.w;
      }

      // Make sure all elements have the same space between them
    }
  });


};


};


if(typeof Quintus === 'undefined') {
  module.exports = quintusSadlierLayout;
} else {
  quintusSadlierLayout(Quintus);
}



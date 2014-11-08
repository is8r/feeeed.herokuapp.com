//----------------------------------------------------------------------
// Staticクラス

var Static = {

  //----------------------------------------------------------------------
  //  プリロード
  //  Static.preload(['images/a.jpg','images/b.jpg']);
  preload : function(ar){
    $(ar).each(function(i){
      $('<img/>')[0].src = this;
    });
    
  },

  //----------------------------------------------------------------------
  //  URLパラメータを受け取り
  //  var xml = Static.getUrlVars();
  //  alert(xml["xml"]);
  getUrlVars : function(){
    var vars = [], hash; 
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&'); 
    for(var i = 0; i < hashes.length; i++) { 
      hash = hashes[i].split('='); 
      vars.push(hash[0]); 
      vars[hash[0]] = hash[1]; 
    } 
    return vars; 
  },

  //----------------------------------------------------------------------
  //  StringやjsonpデータをXMLに変換
  //  var xmlObject = Static.string2xml(xml);
  //  alert(xmlObject);
  string2xml : function(xmlData){
    if (window.ActiveXObject) {
      //for IE
      xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
      xmlDoc.async="false";
      xmlDoc.loadXML(xmlData);
      return xmlDoc;
    } else if (document.implementation && document.implementation.createDocument) {
      //for Mozila
      parser=new DOMParser();
      xmlDoc=parser.parseFromString(xmlData,"text/xml");
      return xmlDoc;
    }
  },

  //----------------------------------------------------------------------
  //オブジェクトの中身を確認
  showObject : function(elm,type){
    var str = '「' + typeof elm + "」の中身";
    var cnt = 0;
    for(i in elm){
      if(type == 'html'){
        str += '<br />?n' + "[" + cnt + "] " + i.bold() + ' = ' + elm[i];
      } else {
        str += '?n' + "[" + cnt + "] " + i + ' = ' + elm[i];
      }
      cnt++;
      status = cnt;
    }
    return str;
  },
  
  //----------------------------------------------------------------------
  //数字の頭に0を足す
  zeroPlus : function(value){
    return (n<10) ? "0"+n : n;
    //return ("0" + value).slice(-2);
  },
  
  //----------------------------------------------------------------------
  //フルパスページの仮ローカル表示
  //Static.fullpath2localpath('http://www.sony.jp');
  fullpath2localpath : function(path){
    $(function(){
      $('script').each(function(i) {
        //if(i != 1) return;
        var src = this.src;
        var count = src.indexOf('/');
        if(count == 5) {
          var full = path + src.substr(count+2, src.length);
          this.src = full;
        }
      });
      $('link').each(function(i) {
        //if(i != 1) return;
        var href = this.href;
        var count = href.indexOf('/');
        if(count == 5) {
          var full = path + href.substr(count+2, href.length);
          this.href = full;
        }
      });
      $('img').each(function(i) {
        //if(i != 1) return;
        var src = this.src;
        var count = src.indexOf('/');
        if(count == 5) {
          var full = path + src.substr(count+2, src.length);
          this.src = full;
        }
      });
    });
  },
  
  //----------------------------------------------------------------------
  
  //  ランダムな数を返す
  //  var n = Static.random(n);
  //  alert(n);
  random : function(n){
    return Math.random()*n;
  },
  
  //  ランダムな数を返す
  //  var n = Static.randomRange(1, 2);
  //  alert(n);
  randomRange : function(min, max){
    return min + Math.random()*(max-min);
  },
  
  //  ランダムな整数を返す
  //  var n = Static.randomInt(n);
  //  alert(n);
  randomInt : function(n){
    return Math.floor(Math.random()*n);
  },
  
  //  0か1をランダムで返す
  //  var n = Static.randomBit();
  //  alert(n);
  randomBit : function(n){
    return (Math.random() < .5) ? 1 : 0;
  },
  
  //  -1か1をランダムで返す
  //  var n = Static.randomSign();
  //  alert(n);
  randomSign : function(n){
    return (Math.random() < .5) ? -1 : 1;
  },
  
  //  2点間の距離を測定
  //  var distance = Static.getDistance(o1,o2);
  //  alert(distance);
  getDistance : function(o1,o2){
    var d,dx,dy;
    dx = o1.x - o2.x;
    dy = o1.y - o2.y;
    d = Math.sqrt(dx*dx+dy*dy);
    return d;
  },

  //  2点間の角度を測定
  //  var r = Static.getDegrees(o1,o2);
  //  var r = Static.getRadians(o1,o2);
  //  alert(r);
  getDegrees : function(o1,o2){
    return (Math.atan2(o2.y-o1.y, o2.x-o1.x)) * 180/Math.PI;
  },
  getRadians : function(o1,o2){
    return Math.atan2(o2.y-o1.y, o2.x-o1.x);
  },
  
  //  2点の中心点を取得
  //  var center = Static.getCenter(o1,o2);
  //  alert(distance);
  getCenter : function(o1,o2){
    var distance = Static.getDistance(o1,o2);
    var rot = Static.getDegrees(o1,o2);
    var dx = Math.cos(rot * Math.PI / 180) * (distance/2); 
    var dy = Math.sin(rot * Math.PI / 180) * (distance/2);
    var x = o1.x+dx;
    var y = o1.y+dy;
    return {x: x, y: y};
  },
  
  //  3点の中心点を取得
  //  var p = Static.getTriangleCenter(triangle);
  //  alert(distance);
  getTriangleCenter : function(triangle){
    var center = Static.getCenter(triangle[0], triangle[1]);
    var center2 = Static.getCenter(triangle[2], center);
    return center2;
  },

  //  ラジアン角に変更
  //  var r = Static.changeRadians(degrees);
  //  alert(r);
  changeRadians : function(degrees){
    return degrees * Math.PI/180;
  },
  //  ラジアン角から変更
  //  var r = Static.changeDegrees(radians);
  //  alert(r);
  changeDegrees : function(radians){
    return radians * 180/Math.PI;
  },
  
  //  sinを配列で返す
  //  var r = Static.getSinWave(1, 100);
  //  trace(r);
  getSinWave : function(value, c){
    var ar = [];
    var angle = 0;
    var limite = value;
          
    var n = 0;
    var max = c;
    var speed = 6.2/max;
    
    for(var i=0;i<max;i++){
      angle += speed;
      n = Math.sin(angle)*limite;
      ar.push(n);
    }
    return ar;
  },
  
  //  cosを配列で返す
  //  var r = Static.getCosWave(1, 100);
  //  trace(r);
  getCosWave : function(value, c){
    var ar = [];
    var angle = 0;
    var limite = value;
          
    var n = 0;
    var max = c;
    var speed = 6.2/max;
    
    for(var i=0;i<max;i++){
      angle += speed;
      n = Math.cos(angle)*limite;
      ar.push(n);
    }
    return ar;
  },
  
  
  //スプライン曲線用
  //Static.getSpline(x0,y0, x1,y1)
  //      var p;//now
  //      var pA;//next
  //      for (var i = 0; i < points.max-1; i++) {
  //        p = points.ary[i];
  //        p.pos.x = i*(stage.w/(points.max-4));
  //      }
  //      
  //      for (var i = 0; i < points.max-1; i++) {
  //        p = points.ary[i];
  //        pA = points.ary[i-1];
  //        if(i == 0) {
  //          context.moveTo(p.pos.x, p.pos.y + plusY);
  //        } else {
  //          var ch = Static.getSpline(pA.pos.x, pA.pos.y, p.pos.x, p.pos.y);
  //          var cx = ch[0];
  //          var cy = ch[1];
  //          context.quadraticCurveTo(pA.pos.x, pA.pos.y + plusY, cx, cy + plusY);
  //        }
  //      }
  //      context.lineTo(stage.w, stage.h);
  //      context.lineTo(0, stage.h);
  //      context.closePath();
  //      context.fill();
  getSpline : function( arg1, arg2, arg3, arg4 )
  {
    var ret = {};
    var Ho = Static.getSplinePoint( arg1, arg2, arg3, arg4 );
    var L = null;
    var S = null;
    if( arg1 < arg3 )
    {
      L = arg3;
      S = arg1;
    }
    else
    {
      L = arg1;
      S = arg3;
    }
    ret[0] = (L -S)/2 +S;
    ret[1] = Ho[0] *ret[0] +Ho[1];
    return ret;
  },
  getSplinePoint : function( arg1, arg2, arg3, arg4 )
  {
    var a = (arg2 - arg4) /(arg1 -arg3);
    var b = arg2 - arg1 *a;
    var ret = Array( a, b );
    return ret;
  },

  //  ランダムな色を取得
  //  var r = Static.randomColor();
  randomColor : function()
  {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
      color += letters[Math.round(Math.random() * 15)];
    }
    return color;
  },
  

  //----------------------------------------------------------------------
  //
  //  iPhone,iPad判別
  //  var bo = Static.isiOS();
  isiOS : function(){
    var bo = false;
    var isiPad = navigator.userAgent.match(/iPad/i) != null;
    var isiPhone = navigator.userAgent.match(/iPhone/i) != null;
    if(isiPad || isiPhone) bo = true;
    return bo;
  },
  isApple : function(){
    return Static.isiOS();
  },
  
  //----------------------------------------------------------------------
  //  IE判別
  //  var bo = Static.isIE();
  //  var bo = Static.isIE6();
  isIE : function(){
    return $.browser.msie;
  },
  isIE6 : function(){
    var bo = false;
    if(Static.isIE && parseInt($.browser.version) == 6) bo = true;
    return bo;
  },
  isIE7 : function(){
    var bo = false;
    if(Static.isIE && parseInt($.browser.version) == 7) bo = true;
    return bo;
  },

  //----------------------------------------------------------------------
  //
  //  アンドロイドバージョン判別
  //  var bo = Static.lowerAndroid(2.2);
  //  alert(bo);//2.2（含まない）以下はtrue
  lowerAndroid : function(n){
    var bo = false;
    var ua = navigator.userAgent.toLowerCase();
    var version = ua.substr(ua.indexOf('android')+8, 3);
    if(ua.indexOf("android")){
      if(parseFloat(version) < n) bo = true;
    }
    return bo;
  },
  
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //エラー回避用
  fin : function(){}
}








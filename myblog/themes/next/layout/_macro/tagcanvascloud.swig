<div class="tags" id="myTags">
  <canvas width="900" height="700" id="my3DTags" style="width:100%">
    <p>Anything in here will be replaced on browsers that support the canvas element</p>
  </canvas>
</div>
<div class="tags" id="tags">
  <ul style="display: none">
    {{ tagcloud({
      min_font: 16,
      max_font: 35,
      amount: 999,
      color: true,
      start_color: '#ccc',
      end_color: '#111',
    }) }}
  </ul>
</div>
<script type="text/javascript" src="/js/src/tagcanvas.min.js"></script>
<script type="text/javascript" >
  window.onload = function() {
    try {
      TagCanvas.Start('my3DTags','tags',{
            textColour: '#000000',
            outlineColour: '#fff',
            reverse: true,
            depth: 0.8,
            maxSpeed: 0.03,
            minSpeed: 0.07,
            shape: "hcylinder",
            initial:[0, 0.1],
            shuffleTags:true,
            textHeight:20,
            centreImage:'/images/uploads/tagcenter.png',
      });
    } catch(e) {
      // something went wrong, hide the canvas container
      document.getElementById('myTags').style.display = 'none';
    }
  };
</script>
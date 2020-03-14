// using d3 for convenience
var main = d3.select('main');
var scrolly = main.select('#scrolly');
var figure = scrolly.select('figure');
var article = scrolly.select('article');
var image = scrolly.select('image');
var step = article.selectAll('.step');
// let subSticky = article.selectAll(".subSticky");

// initialize the scrollama
var scroller = scrollama();

// generic window resize listener event
function handleResize() {
  // 1. update height of step elements
  var stepH = Math.floor(window.innerHeight + 50);
  step.style('height', stepH + 'px');

  var figureHeight = (window.innerHeight * 2) / 3;
  var figureMarginTop = (window.innerHeight - figureHeight) / 2;

  figure
    .style('height', figureHeight + 'px')
    .style('top', figureMarginTop + 'px');

  // subSticky.style("height", 300 + "px").style("top", figureMarginTop + "px");

  // 3. tell scrollama to update new element dimensions
  scroller.resize();
}

// scrollama event handlers
function handleStepEnter(response) {
  console.log(response);
  // response = { element, direction, index }

  // add color to current step only
  step.classed('is-active', function(d, i) {
    return i === response.index;
  });

  figure.select('p').text(response.index + 1);

  console.log(response.index);
  if (response.index === 4) {
    // document
    //   .getElementById('stickyText')
    //   .innerHTML(
    figure
      .select('p')
      .text(
        'I think being forced to not use substances made me want to use even more.'
      );
    document.getElementById('image').className = '';
  } else if (response.index === 5) {
    document.getElementById('image').className = 'prior_Phila';
  } else {
    document.getElementById('image').className = '';
    // document.getElementById('stickyText').innerHTML = '';
  }
}

function setupStickyfill() {
  d3.selectAll('.sticky').each(function() {
    Stickyfill.add(this);
  });
}

function init() {
  setupStickyfill();

  // 1. force a resize on load to ensure proper dimensions are sent to scrollama
  handleResize();

  // 2. setup the scroller passing options
  // 		this will also initialize trigger observations
  // 3. bind scrollama event handlers (this can be chained like below)
  scroller
    .setup({
      step: '#scrolly article .step',
      offset: 0.25
      // ,
      // debug: true
    })
    .onStepEnter(handleStepEnter);

  // setup resize event
  window.addEventListener('resize', handleResize);
}

// kick things off
init();

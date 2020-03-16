// using d3 for convenience
var main = d3.select('main');
var scrolly = main.select('#scrolly');
var figure = scrolly.select('figure');
var article = scrolly.select('article');
var image = scrolly.select('image');
var step = article.selectAll('.step');
var progress = main.select('.progress');
// let subSticky = article.selectAll(".subSticky");

// initialize the scrollama
var scroller = scrollama();

// generic window resize listener event
function handleResize() {
  // 1. update height of step elements
  var stepHeight = Math.floor(window.innerHeight + 50);
  if (stepHeight > 1000) stepHeight = 1000;

  step.style('height', stepHeight + 'px');

  var figureHeight = (window.innerHeight * 2) / 3;
  if (figureHeight > 500) figureHeight = 500;
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
  // step.classed('is-active', function(d, i) {
  //   return i === response.index;
  // });

  console.log(response.index);
  if (response.index === 0) {
    document.getElementById('image').className = 'refusal';
    figure
      .select('h4')
      .text(
        'The blue line and shaded area show the trend of people who have overdosed increasingly refusing transport to hospitals after treatment by emergency medical personnel.'
      );
  } else if (response.index === 1) {
    document.getElementById('image').className = 'homeless';
    figure.select('h4').text('');
  } else if (response.index === 2) {
    document.getElementById('image').className = 'homeless-pie-charts';
  }
  // else if (response.index === 3) {
  //   figure.select('p').text(response.index);
  // } else if (response.index === 4) {
  //   figure
  //     .select('p')
  //     .text(
  //       '"I think being forced to not use substances made me want to use even more."'
  //     );
  //   document.getElementById('image').className = '';
  //   figure.select('h4').text('');
  // } else if (response.index === 5) {
  //   figure.select('p').text('');
  //   document.getElementById('image').className = 'prior_Phila';
  //   figure
  //     .select('h4')
  //     .text(
  //       'More than 80% of residential rehab have been treated previously. ~50% have been in treatment at least 3 times. Nationally, the breakdown is almost the same, but with more people in the 5 or more category.'
  //     );
  // } else if (response.index === 6) {
  //   document.getElementById('image').className = '';
  //   figure.select('h4').text('');
  //   figure.select('p').text(response.index);
  // } else if (response.index === 7) {
  //   document.getElementById('image').className = '';
  //   figure
  //     .select('p')
  //     .text(
  //       '"I continued using and finding ways and means not to go into withdrawal."'
  //     );
  //   figure.select('h4').text('');
  // } else if (response.index === 8) {
  //   figure.select('p').text('');
  //   document.getElementById('image').className = 'mat1';
  //   figure
  //     .select('h4')
  //     .text(
  //       'Vivitrol is a time-release form of naltrexone. It and other medications, notably buprenorphine, are successful in preventing opioid withdrawal. Despite medically assisted treatment (MAT) gaining increasing acceptance overall, it is much less likely to be offered to people referred to treatment by prisons or courts.'
  //     );
  //   document.getElementById('stickyText').classList.remove('smart-text');
  // } else if (response.index === 9) {
  //   document.getElementById('image').className = '';
  //   figure.select('h4').text('');
  //   document.getElementById('stickyText').classList.add('smart-text');
  //   document.getElementById('stickyText').textContent +=
  //     'Self-Management And Recovery Training (SMART) employs a “science-based” approach to help people dealing with any type of addiction to “find and develop the power within themselves to change and lead fulfilling and balanced lives.” It is open to Medication Assisted Treatment (MAT), whereas NA and AA focus more narrowly on abstinence. They tend to see people using MAT as not clean/sober, although a number of people using MAT for their recovery have reportedly found AA more accepting of their situation.';
  // } else if (response.index === 10) {
  //   document.getElementById('stickyText').classList.remove('smart-text');
  //   document.getElementById('stickyText').textContent = '';
  //   figure.select('p').text(response.index);
  // } else if (response.index === 11) {
  //   figure.select('p').text(response.index);
  // }
  else {
    figure.select('h4').text('');
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
      offset: 0.33
      // ,
      // debug: true
    })
    .onStepEnter(handleStepEnter);

  // setup resize event
  window.addEventListener('resize', handleResize);

  window.addEventListener('scroll', () => {
    let progress = document.getElementById('progress');
    if (window.scrollY > progress.offsetTop - 100) {
      document.getElementById('progress').style.visibility = 'visible';
      document.getElementById('progress').style.opacity = '1';
    }
  });

  window.addEventListener('scroll', () => {
    let progress = document.getElementById('progress');
    if (window.scrollY < progress.offsetTop - 100) {
      progress.style.visibility = 'hidden';
      progress.style.opacity = '0';
    }

    // console.log(window.scrollY, progress.offsetTop);
  });
}

// kick things off
init();

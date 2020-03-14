const container = document.querySelector('.container');
const coffees = [
  {
    name: 'Nicole',
    image: 'images/boy.svg',
    link: 'personaOne.html'
  },
  {
    name: 'Michael',
    image: 'images/man.svg',
    link: 'personaTwo.html'
  },
  {
    name: 'Sandra',
    image: 'images/girl.svg',
    link: 'personaThree.html'
  }
];
const showPersonas = () => {
  let output = '';
  coffees.forEach(
    ({ name, image, link }) =>
      (output += `
              <div class="card">
                <img class="card--avatar" src=${image} />
                <h1 class="card--title">${name}</h1>
                <a class="card--link" href=${link}>Read ${name}'s story</a>
              </div>
              `)
  );
  container.innerHTML = output;
};

document.addEventListener('DOMContentLoaded', showPersonas);

if ('serviceWorker' in navigator) {
  window.addEventListener('load', function() {
    navigator.serviceWorker
      .register('/serviceWorker.js')
      .then(res => console.log('service worker registered'))
      .catch(err => console.log('service worker not registered', err));
  });
}

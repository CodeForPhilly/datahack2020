const container = document.querySelector('.container');
const coffees = [
  {
    name: 'Persona 1',
    image: 'images/boy.svg'
  },
  {
    name: 'Persona 2',
    image: 'images/girl.svg'
  },
  {
    name: 'Persona 3',
    image: 'images/man.svg'
  }
];
const showPersonas = () => {
  let output = '';
  coffees.forEach(
    ({ name, image }) =>
      (output += `
              <div class="card">
                <img class="card--avatar" src=${image} />
                <h1 class="card--title">${name}</h1>
                <a class="card--link" href="personaOne.html">Read More</a>
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

// Función para cargar el CSS
async function loadNavbarCSS() {
    try {
        // Determinar si estamos en la página principal o en un subdirectorio
        const isRoot = window.location.pathname.split('/').filter(Boolean).length <= 1;
        const cssPath = isRoot ? 'navbar/navbar.css' : '../navbar/navbar.css';
        
        const response = await fetch(cssPath);
        const css = await response.text();
        
        // Crear elemento style
        const style = document.createElement('style');
        style.textContent = css;
        
        // Insertar en el head antes que cualquier otro CSS
        const firstStyle = document.head.querySelector('style, link[rel="stylesheet"]');
        if (firstStyle) {
            document.head.insertBefore(style, firstStyle);
        } else {
            document.head.appendChild(style);
        }
    } catch (error) {
        console.error('Error loading navbar CSS:', error);
    }
}

// Cargar el CSS cuando se carga el script
loadNavbarCSS();

// Definir la clase del componente
class NavBar extends HTMLElement {
    constructor() {
        super();
        const isRoot = window.location.pathname.split('/').filter(Boolean).length <= 1;
        const path = isRoot ? '' : '../';
        
        fetch(`${path}navbar/navbar.html`)
            .then(response => response.text())
            .then(html => {
                this.innerHTML = html.replace(/\${path}/g, path);
            })
            .catch(error => console.error('Error loading navbar:', error));
    }
}

// Registrar el componente
customElements.define('nav-bar', NavBar);

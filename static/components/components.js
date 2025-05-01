// Función para cargar el CSS del navbar y del footer
async function loadCSS() {
    try {
        // Determinar si estamos en la página principal o en un subdirectorio
        const isRoot = window.location.pathname.split('/').filter(Boolean).length <= 1;
        const cssPath = isRoot ? 'static/components/components.css' : '../static/components/components.css';
        
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
        console.error('Error loading CSS of components (navbar & footer):', error);
    }
}

// Cargar el CSS cuando se carga el script
loadCSS();

// Definir la clase del componente del navbar
class NavBar extends HTMLElement {
    constructor() {
        super();
        const isRoot = window.location.pathname.split('/').filter(Boolean).length <= 1;
        const path = isRoot ? '' : '../';
        
        fetch(`${path}static/components/navbar.html`)
            .then(response => response.text())
            .then(html => {
                this.innerHTML = html.replace(/\${path}/g, path);
            })
            .catch(error => console.error('Error loading navbar:', error));
    }
}

// Definir la clase del componente del footer
class Footer extends HTMLElement {
    constructor() {
        super();
        const isRoot = window.location.pathname.split('/').filter(Boolean).length <= 1;
        const path = isRoot ? '' : '../';
        
        fetch(`${path}static/components/footer.html`)
            .then(response => response.text())
            .then(html => {
                this.innerHTML = html.replace(/\${path}/g, path);
            })
            .catch(error => console.error('Error loading footer:', error));
    }
}

// Registrar los componentes
customElements.define('load-navbar', NavBar);
customElements.define('load-footer', Footer);

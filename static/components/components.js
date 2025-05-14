// Función para cargar el CSS del navbar y del footer
async function loadCSS() {
    try {
        // Determinar si estamos en la página principal o en un subdirectorio
        const isRoot =
            window.location.pathname.split("/").filter(Boolean).length <= 1;
        const cssPath = isRoot
            ? "static/components/components.css"
            : "../static/components/components.css";

        const response = await fetch(cssPath);
        const css = await response.text();

        // Crear elemento style
        const style = document.createElement("style");
        style.textContent = css;

        // Insertar en el head antes que cualquier otro CSS
        const firstStyle = document.head.querySelector(
            'style, link[rel="stylesheet"]'
        );
        if (firstStyle) {
            document.head.insertBefore(style, firstStyle);
        } else {
            document.head.appendChild(style);
        }
    } catch (error) {
        console.error(
            "Error loading CSS of components (navbar & footer):",
            error
        );
    }
}

// Cargar el CSS cuando se carga el script
loadCSS();

// Definir la clase del componente del logo (para insertarlo fácilmente)
// class LogoLaCadena extends HTMLElement {
//     constructor() {
//         super();
//         this.innerHTML = `
//         <svg viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" class="logo" width="100" height="100">
//           <rect width="100%" height="100%" fill="#EB473D"/>
//           <g fill="#F8F9FA" transform="translate(71.447342, 64)">
//             <path d="M237.238,46.437 L330.114,139.313 L280.552658,288 L15.466,376.362 L179.038345,212.613806 C180.797325,213.083146 182.645775,213.333333 184.552658,213.333333 C196.334733,213.333333 205.885991,203.782075 205.885991,192 C205.885991,180.217925 196.334733,170.666667 184.552658,170.666667 C172.770583,170.666667 163.219325,180.217925 163.219325,192 C163.219325,193.915222 163.471705,195.771497 163.945022,197.537382 L0,361.66 L88.552658,96 L237.238,46.437 Z M291.219325,0 L376.552658,85.3333333 L341.428,120.457 L256.095,35.124 L291.219325,0 Z"/>
//           </g>
//         </svg>
//       `;
//     }
// }

// Definir la clase del componente del navbar
class NavBar extends HTMLElement {
    constructor() {
        super();
        const isRoot =
            window.location.pathname.split("/").filter(Boolean).length <= 1;
        const path = isRoot ? "" : "../";

        fetch(`${path}static/components/navbar.html`)
            .then((response) => response.text())
            .then((html) => {
                this.innerHTML = html.replace(/\${path}/g, path);

                // Hamburger
                const hamburger = this.querySelector('#hamburger');
                const nav = this.querySelector('nav'); // document.querySelector('nav') si nav está fuera

                if (hamburger && nav) {
                    hamburger.addEventListener('click', () => {
                        nav.classList.toggle('open');
                    });
                } else {
                    console.warn('hamburger or nav not found after navbar load');
                }
            })
            .catch((error) => console.error("Error loading navbar:", error));
    }
}


// Definir la clase del componente del footer
class Footer extends HTMLElement {
    constructor() {
        super();
        const isRoot =
            window.location.pathname.split("/").filter(Boolean).length <= 1;
        const path = isRoot ? "" : "../";

        fetch(`${path}static/components/footer.html`)
            .then((response) => response.text())
            .then((html) => {
                this.innerHTML = html.replace(/\${path}/g, path);
            })
            .catch((error) => console.error("Error loading footer:", error));
    }
}

// Registrar los componentes
// customElements.define("la-cadena", LogoLaCadena);
customElements.define("load-navbar", NavBar);
customElements.define("load-footer", Footer);

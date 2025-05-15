document.addEventListener('DOMContentLoaded', () => {
    const numSerie = getNumSerieFromURL();
    if (!numSerie) {
        renderError('Producto no encontrado.');
        return;
    }
    fetch(`producto_api.php?num_serie=${encodeURIComponent(numSerie)}`)
        .then(res => res.json())
        .then(producto => {
            if (!producto || !producto.nombre) {
                renderError('Producto no encontrado.');
            } else {
                renderProducto(producto);
            }
        })
        .catch(() => renderError('Error al cargar el producto.'));
});

function getNumSerieFromURL() {
    const path = window.location.pathname;
    const match = path.match(/\/tienda\/([^\/]+)$/);
    return match ? match[1] : null;
}

function renderProducto(producto) {
    const main = document.querySelector('main.tienda');
    main.innerHTML = `
        <section class="producto-detalle">
            <div class="producto-detalle-img">
                <img src="${producto.imagen || '../static/img/no-image.png'}" alt="${producto.nombre}">
            </div>
            <div class="producto-detalle-info">
                <h1>${producto.nombre}</h1>
                <div class="producto-detalle-precio">$${producto.precio.toLocaleString('es-MX')}</div>
                <div class="producto-detalle-desc">${producto.descripcion || ''}</div>
                <button class="producto-detalle-btn" disabled>Comprar ahora</button>
            </div>
        </section>
    `;
}

function renderError(msg) {
    const main = document.querySelector('main.tienda');
    main.innerHTML = `<div class="admin-error" style="padding:40px;text-align:center;">${msg}</div>`;
} 
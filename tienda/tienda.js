document.addEventListener('DOMContentLoaded', () => {
    fetch('productos_api.php')
        .then(res => res.json())
        .then(productos => renderProductos(productos));
});

function renderProductos(productos) {
    const grid = document.getElementById('tienda-grid');
    if (!productos.length) {
        grid.innerHTML = '<p>No hay productos disponibles.</p>';
        return;
    }
    grid.innerHTML = productos.map(producto => `
        <div class="producto-card" data-num-serie="${producto.num_serie}">
            <img src="../static/img/no-image.png" alt="${producto.nombre}">
            <div class="producto-info">
                <div class="producto-nombre">${producto.nombre}</div>
                <div class="producto-precio">MXN ${producto.precio.toLocaleString('es-MX')}</div>
            </div>
        </div>
    `).join('');
    // Agregar listeners para navegación
    Array.from(document.querySelectorAll('.producto-card')).forEach(card => {
        card.addEventListener('click', () => {
            const numSerie = card.getAttribute('data-num-serie');
            if (numSerie) {
                window.location.href = `${numSerie}`;
            }
        });
    });
} 
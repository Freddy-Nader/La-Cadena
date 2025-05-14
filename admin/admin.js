const sections = ['productos', 'usuarios', 'carrito', 'historial', 'sql'];

function showSection(section) {
    // Cambia el botón activo
    document.querySelectorAll('.admin-nav button').forEach(btn => btn.classList.remove('active'));
    const btn = Array.from(document.querySelectorAll('.admin-nav button')).find(b => b.textContent.toLowerCase().includes(section));
    if (btn) btn.classList.add('active');
    // Carga el contenido de la sección
    if (section === 'sql') {
        renderSQLSection();
    } else {
        fetchSectionData(section);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    showSection('productos');
});

function fetchSectionData(section) {
    fetch('admin_api.php?action=list&table=' + section)
        .then(res => res.json())
        .then(data => renderTableSection(section, data))
        .catch(() => {
            document.getElementById('admin-content').innerHTML = '<div class="admin-error">Error al cargar los datos.</div>';
        });
}

function renderTableSection(section, data) {
    let html = '';
    if (data.error) {
        html += `<div class="admin-error">${data.error}</div>`;
    }
    html += `<h2>${capitalize(section)}</h2>`;
    if (data.columns && data.columns.length) {
        // Formulario de inserción
        html += `<form class="admin-form" onsubmit="return submitForm(event, '${section}')">`;
        data.columns.forEach(col => {
            if (col === 'id' || col.startsWith('id_')) return; // No permitir editar PK/FK aquí
            html += `<label>${col}: <input name="${col}" required></label>`;
        });
        html += `<button type="submit">Agregar</button></form>`;
        // Tabla de datos
        html += `<table class="admin-table"><thead><tr>`;
        data.columns.forEach(col => html += `<th>${col}</th>`);
        html += `<th>Acciones</th></tr></thead><tbody>`;
        data.rows.forEach(row => {
            html += '<tr>';
            data.columns.forEach(col => html += `<td>${row[col]}</td>`);
            html += `<td>
                <button onclick="editRow('${section}', ${row[data.pk]})">Editar</button>
                <button onclick="deleteRow('${section}', ${row[data.pk]})">Eliminar</button>
            </td>`;
            html += '</tr>';
        });
        html += '</tbody></table>';
    } else {
        html += '<div>No hay datos.</div>';
    }
    document.getElementById('admin-content').innerHTML = html;
}

function submitForm(e, section) {
    e.preventDefault();
    const form = e.target;
    const data = new FormData(form);
    data.append('action', 'insert');
    data.append('table', section);
    fetch('admin_api.php', { method: 'POST', body: data })
        .then(res => res.json())
        .then(resp => {
            if (resp.success) {
                fetchSectionData(section);
            } else {
                alert(resp.error || 'Error al insertar');
            }
        });
    return false;
}

function deleteRow(section, id) {
    if (!confirm('¿Seguro que deseas eliminar este registro?')) return;
    fetch('admin_api.php', {
        method: 'POST',
        body: new URLSearchParams({ action: 'delete', table: section, id })
    })
    .then(res => res.json())
    .then(resp => {
        if (resp.success) fetchSectionData(section);
        else alert(resp.error || 'Error al eliminar');
    });
}

function editRow(section, id) {
    fetch('admin_api.php?action=get&table=' + section + '&id=' + id)
        .then(res => res.json())
        .then(data => {
            if (data.error) return alert(data.error);
            let html = `<h2>Editar ${capitalize(section)}</h2>`;
            html += `<form class="admin-form" onsubmit="return submitEditForm(event, '${section}', ${id})">`;
            data.columns.forEach(col => {
                if (col === 'id' || col.startsWith('id_')) {
                    html += `<label>${col}: <input name="${col}" value="${data.row[col]}" readonly></label>`;
                } else {
                    html += `<label>${col}: <input name="${col}" value="${data.row[col]}" required></label>`;
                }
            });
            html += `<button type="submit">Guardar</button> <button onclick="fetchSectionData('${section}');return false;">Cancelar</button></form>`;
            document.getElementById('admin-content').innerHTML = html;
        });
}

function submitEditForm(e, section, id) {
    e.preventDefault();
    const form = e.target;
    const data = new FormData(form);
    data.append('action', 'update');
    data.append('table', section);
    data.append('id', id);
    fetch('admin_api.php', { method: 'POST', body: data })
        .then(res => res.json())
        .then(resp => {
            if (resp.success) fetchSectionData(section);
            else alert(resp.error || 'Error al actualizar');
        });
    return false;
}

function renderSQLSection() {
    document.getElementById('admin-content').innerHTML = `
        <h2>Ejecutar SQL Directo</h2>
        <form class="admin-sql" onsubmit="return submitSQL(event)">
            <textarea name="sql" placeholder="Escribe tu consulta SQL aquí..."></textarea>
            <button type="submit">Ejecutar</button>
        </form>
        <div id="sql-result"></div>
        <div style="color:#b32a1c;font-size:0.95em;margin-top:10px;">⚠️ Usa esta función con precaución. No se recomienda en producción.</div>
    `;
}

function submitSQL(e) {
    e.preventDefault();
    const sql = e.target.sql.value;
    fetch('admin_api.php', {
        method: 'POST',
        body: new URLSearchParams({ action: 'sql', sql })
    })
    .then(res => res.json())
    .then(resp => {
        let html = '';
        if (resp.error) {
            html = `<div class="admin-error">${resp.error}</div>`;
        } else if (resp.result) {
            html = '<div class="admin-sql-result"><table class="admin-table"><thead><tr>';
            if (resp.columns) resp.columns.forEach(col => html += `<th>${col}</th>`);
            html += '</tr></thead><tbody>';
            if (resp.rows) resp.rows.forEach(row => {
                html += '<tr>';
                resp.columns.forEach(col => html += `<td>${row[col]}</td>`);
                html += '</tr>';
            });
            html += '</tbody></table></div>';
        } else {
            html = `<div class="admin-success">Consulta ejecutada correctamente.</div>`;
        }
        document.getElementById('sql-result').innerHTML = html;
    });
    return false;
}

function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
} 
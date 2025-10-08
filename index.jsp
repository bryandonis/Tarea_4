<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>UMG · CRUD Estudiantes (JSP + Bootstrap, sin BD)</title>

  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

  <style>
    body{ padding-bottom: 60px; }
    .footer {
      position: fixed; left: 0; right: 0; bottom: 0;
      background:#f8f9fa; border-top:1px solid #dee2e6; padding:.5rem 1rem;
      font-size:.9rem; color:#6c757d;
    }
    .table-hover tbody tr{ cursor:pointer; }
    .required::after{ content:" *"; color:#dc3545; }
  </style>
</head>
<body class="bg-light">

  <!-- NAVBAR -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand fw-semibold" href="#">UMG · Sistemas</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div id="mainNav" class="collapse navbar-collapse">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item"><a class="nav-link active" href="#">Inicio</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Nosotros</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Contacto</a></li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Sub Menú</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Opción 1</a></li>
              <li><a class="dropdown-item" href="#">Opción 2</a></li>
            </ul>
          </li>
        </ul>
        <span class="navbar-text text-white-50">Demo sin base de datos</span>
      </div>
    </div>
  </nav>

  <main class="container my-4">
    <div class="d-flex align-items-center justify-content-between mb-3">
      <h1 class="h4 m-0">CRUD Estudiantes (JSP, HTML, CSS, JS, Bootstrap)</h1>
      <button class="btn btn-info text-white" id="btnNuevo">
        <i class="bi bi-plus-circle"></i> Nuevo
      </button>
    </div>

    <!-- Tabla -->
    <div class="card shadow-sm">
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped table-hover align-middle mb-0" id="tblEstudiantes">
            <thead class="table-dark">
              <tr>
                <th>Carne</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Dirección</th>
                <th>Teléfono</th>
                <th>Correo</th>
                <th>Sangre</th>
                <th>Nacimiento</th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>
      </div>
    </div>
  </main>

  <!-- Modal -->
  <div class="modal fade" id="modalEstudiante" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Datos del Estudiante</h5>
          <button class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body">
          <form id="frmEstudiante" class="row g-3" novalidate>
            <input type="hidden" id="idx" />
            <div class="col-12 col-md-4">
              <label class="form-label required" for="carne">Carné</label>
              <input type="text" class="form-control" id="carne" required
                     placeholder="E001"
                     pattern="E(00[1-9]|0[1-9][0-9]|[1-9][0-9]{2})" />
              <div class="form-text">Formato válido: E001 a E999</div>
              <div class="invalid-feedback">Ingresa un carné válido (E001–E999).</div>
            </div>
            <div class="col-12 col-md-4">
              <label class="form-label required" for="nombres">Nombres</label>
              <input type="text" class="form-control" id="nombres" required />
              <div class="invalid-feedback">Este campo es obligatorio.</div>
            </div>
            <div class="col-12 col-md-4">
              <label class="form-label required" for="apellidos">Apellidos</label>
              <input type="text" class="form-control" id="apellidos" required />
              <div class="invalid-feedback">Este campo es obligatorio.</div>
            </div>
            <div class="col-12 col-md-6">
              <label class="form-label" for="direccion">Dirección</label>
              <input type="text" class="form-control" id="direccion" />
            </div>
            <div class="col-12 col-md-3">
              <label class="form-label" for="telefono">Teléfono</label>
              <input type="tel" class="form-control" id="telefono" inputmode="numeric" pattern="[0-9]{5,15}" placeholder="555555" />
              <div class="invalid-feedback">Solo números (5–15 dígitos).</div>
            </div>
            <div class="col-12 col-md-3">
              <label class="form-label" for="correo">Correo electrónico</label>
              <input type="email" class="form-control" id="correo" placeholder="usuario@dominio.com" />
              <div class="invalid-feedback">Correo no válido.</div>
            </div>
            <div class="col-12 col-md-4">
              <label class="form-label" for="tipoSangre">Tipo de sangre</label>
              <select class="form-select" id="tipoSangre">
                <option value=""><<< Elija >>></option>
                <option>1) A +</option>
                <option>2) O -</option>
                <option>3) B +</option>
                <option>4) AB -</option>
              </select>
            </div>
            <div class="col-12 col-md-4">
              <label class="form-label" for="nacimiento">Fecha de nacimiento</label>
              <input type="date" class="form-control" id="nacimiento" />
            </div>
          </form>
        </div>
        <div class="modal-footer d-flex justify-content-between">
          <div class="d-flex gap-2">
            <button class="btn btn-info text-white" id="btnAgregar">Agregar</button>
            <button class="btn btn-primary" id="btnModificar">Modificar</button>
            <button class="btn btn-danger" id="btnEliminar">Eliminar</button>
          </div>
          <button class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
        </div>
      </div>
    </div>
  </div>

  <div class="footer text-center">
    Desarrollo Web: Demo académico · Universidad Mariano Gálvez de Guatemala
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    const KEY = "estudiantes_umg";
    const $ = (sel) => document.querySelector(sel);
    const modal = new bootstrap.Modal('#modalEstudiante');

    function leer() { return JSON.parse(localStorage.getItem(KEY) || "[]"); }
    function guardar(arr) { localStorage.setItem(KEY, JSON.stringify(arr)); }

    (function seed(){
      if (!localStorage.getItem(KEY)) {
        guardar([
          { carne:"E001", nombres:"Alejandra", apellidos:"Paz",
            direccion:"Guatemala", telefono:"555555",
            correo:"paiz2790@gmail.com", tipoSangre:"4) AB -",
            nacimiento:"2017-09-14" },
          { carne:"E002", nombres:"Armando", apellidos:"Cardona Paiz",
            direccion:"28 calle zona 5 guatemala", telefono:"58795503",
            correo:"paiz2790@gmail.com", tipoSangre:"2) O -",
            nacimiento:"1986-10-10" }
        ]);
      }
    })();

    function render(){
      const tbody = document.querySelector('#tblEstudiantes tbody');
      const data = leer();
      tbody.innerHTML = data.map((e,i)=>`
        <tr data-index="\${i}">
          <td>\${e.carne}</td>
          <td>\${e.nombres}</td>
          <td>\${e.apellidos}</td>
          <td>\${e.direccion||""}</td>
          <td>\${e.telefono||""}</td>
          <td>\${e.correo||""}</td>
          <td>\${e.tipoSangre||""}</td>
          <td>\${e.nacimiento||""}</td>
        </tr>
      `).join('');
    }

    function limpiarForm(){
      $('#idx').value = "";
      $('#frmEstudiante').reset();
      $('#frmEstudiante').classList.remove('was-validated');
    }
    function llenarForm(e, idx){
      $('#idx').value = idx;
      $('#carne').value = e.carne;
      $('#nombres').value = e.nombres;
      $('#apellidos').value = e.apellidos;
      $('#direccion').value = e.direccion||"";
      $('#telefono').value = e.telefono||"";
      $('#correo').value = e.correo||"";
      $('#tipoSangre').value = e.tipoSangre||"";
      $('#nacimiento').value = e.nacimiento||"";
    }

    function datosForm(){
      const form = $('#frmEstudiante');
      const carneInput = $('#carne');
      carneInput.addEventListener('invalid', () => {
        if (carneInput.validity.patternMismatch) {
          carneInput.setCustomValidity('Formato requerido: E001 a E999');
        } else {
          carneInput.setCustomValidity('');
        }
      });
      carneInput.addEventListener('input', () => carneInput.setCustomValidity(''));
      form.classList.add('was-validated');
      if (!form.checkValidity()) return null;
      return {
        carne: $('#carne').value.trim().toUpperCase(),
        nombres: $('#nombres').value.trim(),
        apellidos: $('#apellidos').value.trim(),
        direccion: $('#direccion').value.trim(),
        telefono: $('#telefono').value.trim(),
        correo: $('#correo').value.trim(),
        tipoSangre: $('#tipoSangre').value,
        nacimiento: $('#nacimiento').value
      };
    }

    $('#btnNuevo').addEventListener('click', ()=>{
      limpiarForm();
      $('#btnAgregar').disabled=false;
      $('#btnModificar').disabled=true;
      $('#btnEliminar').disabled=true;
      modal.show(); $('#carne').focus();
    });

    $('#btnAgregar').addEventListener('click', ()=>{
      const d = datosForm(); if(!d) return;
      const data = leer();
      if (data.some(x=>x.carne===d.carne)) { alert('El carné ya existe. Usa otro.'); return; }
      data.push(d); guardar(data); render(); modal.hide();
    });

    $('#btnModificar').addEventListener('click', ()=>{
      const d = datosForm(); if(!d) return;
      const idx = parseInt($('#idx').value);
      const data = leer();
      if (data.some((x,i)=>x.carne===d.carne && i!==idx)) { alert('El carné ingresado ya está usado por otro registro.'); return; }
      data[idx] = d; guardar(data); render(); modal.hide();
    });

    $('#btnEliminar').addEventListener('click', ()=>{
      const idx = parseInt($('#idx').value);
      if (Number.isNaN(idx)) return;
      if (confirm('¿Desea eliminar?')) {
        const data = leer(); data.splice(idx,1); guardar(data); render(); modal.hide();
      }
    });

    document.querySelector('#tblEstudiantes tbody').addEventListener('click', (ev)=>{
      const tr = ev.target.closest('tr'); if(!tr) return;
      const idx = parseInt(tr.getAttribute('data-index'));
      const e = leer()[idx];
      limpiarForm(); llenarForm(e, idx);
      $('#btnAgregar').disabled=true;
      $('#btnModificar').disabled=false;
      $('#btnEliminar').disabled=false;
      modal.show();
    });

    render();
  </script>
</body>
</html>

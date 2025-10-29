/* fs_app.js — FS QuizMaster (Facundo Salazar)
   Lado cliente: iniciar, cargar preguntas (API), responder, puntaje y timer.
   Importante: exponemos funciones en window (fs_iniciar, fs_responder). */

let fs_estado = {
  fs_nombre:'', fs_lista:[], fs_idx:0, fs_ok:0, fs_total:10,
  fs_bloq:false, fs_tiempoMax:20, fs_timer:null, fs_restante:20,
  fs_det:[], fs_inicio:0
};

function fs_mostrarError(msg){
  const e = document.getElementById('fs_error');
  if (!e) return;
  e.style.display='block';
  e.textContent = msg;
}

function fs_iniciar(){
  try{
    const nom  = document.getElementById('fs_nombre').value.trim();
    const cant = parseInt(document.getElementById('fs_cant').value||'10',10);
    if (!nom){ alert('Ingresá tu nombre'); return; }
    fs_estado.fs_nombre = nom;
    fs_estado.fs_total  = Math.min(Math.max(cant,3),20);

    document.getElementById('fs_setup').style.display='none';
    document.getElementById('fs_juego').style.display='block';

    fs_estado.fs_inicio = Date.now();
    fs_cargarPreguntas();
  }catch(err){ console.error(err); fs_mostrarError('Error al iniciar.'); }
}

async function fs_cargarPreguntas(){
  try{
    document.getElementById('fs_contenedor').innerHTML = '<div class="fs_spinner" aria-label="Cargando"></div>';
    const resp = await fetch('./fs_php/fs_api_preguntas.php?fs_cant='+fs_estado.fs_total, {cache:'no-store'});
    if (!resp.ok){ throw new Error('API preguntas devolvió '+resp.status); }
    const j = await resp.json();
    if (!j.ok || !Array.isArray(j.fs_preguntas) || j.fs_preguntas.length===0){
      throw new Error('La API no trajo preguntas.');
    }
    fs_estado.fs_lista = j.fs_preguntas;
    fs_estado.fs_idx = 0; fs_estado.fs_ok = 0; fs_estado.fs_det = [];
    fs_pintarPregunta();
  }catch(err){
    console.error(err);
    fs_mostrarError('No se pudieron cargar preguntas. Revisá fs_php/fs_api_preguntas.php y la BD.');
  }
}

function fs_tick(){
  fs_estado.fs_restante--;
  const t = document.getElementById('fs_timer');
  if (t) t.innerText = fs_estado.fs_restante + 's';
  if (fs_estado.fs_restante<=0) fs_penalizarTiempo();
}
function fs_startTimer(){
  fs_stopTimer(); fs_estado.fs_restante = fs_estado.fs_tiempoMax;
  const t = document.getElementById('fs_timer');
  if (t) t.innerText = fs_estado.fs_restante + 's';
  fs_estado.fs_timer = setInterval(fs_tick, 1000);
}
function fs_stopTimer(){ if (fs_estado.fs_timer){ clearInterval(fs_estado.fs_timer); fs_estado.fs_timer=null; } }

function fs_pintarUI(){
  const pct = Math.floor((fs_estado.fs_idx)/fs_estado.fs_total*100);
  const bar = document.getElementById('fs_bar_fill'); if (bar) bar.style.width = pct + '%';
  const info = document.getElementById('fs_info');
  if (info) info.innerText = `Pregunta ${Math.min(fs_estado.fs_idx+1, fs_estado.fs_total)} / ${fs_estado.fs_total}`;
  const sc = document.getElementById('fs_score'); if (sc) sc.innerText = `Puntaje: ${fs_estado.fs_ok}`;
}

function fs_pintarPregunta(){
  if (fs_estado.fs_idx >= fs_estado.fs_total){ return fs_finalizar(); }
  const p = fs_estado.fs_lista[fs_estado.fs_idx];
  const cont = document.getElementById('fs_contenedor');
  cont.innerHTML = `
    <div class="fs_preg">${p.fs_enunciado}</div>
    <div class="fs_opc">
      ${['A','B','C','D'].map(L => `
        <button id="fs_b_${L}" class="fs_opc_btn" onclick="fs_responder('${L}')">
          <span class="fs_badge">${L}</span> ${p['fs_opcion_'+L.toLowerCase()]}
        </button>`).join('')}
    </div>`;
  fs_pintarUI(); fs_startTimer(); fs_estado.fs_bloq=false;
}

function fs_responder(L){
  if (fs_estado.fs_bloq) return;
  fs_estado.fs_bloq = true; fs_stopTimer();

  const p = fs_estado.fs_lista[fs_estado.fs_idx];
  const ok = (L === p.fs_correcta);
  const tUsado = fs_estado.fs_tiempoMax - fs_estado.fs_restante;

  const base = ok ? 100 : 0;
  const bonus = ok ? Math.max(0, fs_estado.fs_restante*3) : 0;
  fs_estado.fs_ok += (base + bonus);

  const btnSel = document.getElementById('fs_b_'+L);
  if (btnSel) btnSel.classList.add(ok ? 'fs_ok' : 'fs_bad');
  if (!ok){
    const btnOk = document.getElementById('fs_b_'+p.fs_correcta);
    if (btnOk) btnOk.classList.add('fs_ok');
  }

  fs_estado.fs_det.push({preg_id:p.id, resp:L, ok: ok?1:0, t_seg:tUsado});
  setTimeout(()=>{ fs_estado.fs_idx++; fs_pintarUI(); fs_pintarPregunta(); }, 650);
}

function fs_penalizarTiempo(){
  if (fs_estado.fs_bloq) return;
  fs_estado.fs_bloq = true; fs_stopTimer();
  const p = fs_estado.fs_lista[fs_estado.fs_idx];
  fs_estado.fs_ok -= 20;
  fs_estado.fs_det.push({preg_id:p.id, resp:'-', ok:0, t_seg:fs_estado.fs_tiempoMax});
  setTimeout(()=>{ fs_estado.fs_idx++; fs_pintarUI(); fs_pintarPregunta(); }, 400);
}

async function fs_finalizar(){
  try{
    const dur = Math.round((Date.now()-fs_estado.fs_inicio)/1000);
    await fetch('./fs_php/fs_api_guardar.php', {
      method:'POST', headers:{'Content-Type':'application/json'},
      body: JSON.stringify({
        fs_nombre:fs_estado.fs_nombre,
        fs_puntaje:fs_estado.fs_ok,
        fs_total:fs_estado.fs_total,
        fs_duracion:dur,
        fs_detalle:fs_estado.fs_det
      })
    }).catch(()=>{});
    location.href = './fs_resultados.php?fs_nombre=' + encodeURIComponent(fs_estado.fs_nombre) +
                    '&fs_ok=' + fs_estado.fs_ok + '&fs_total=' + fs_estado.fs_total +
                    '&fs_dur=' + dur;
  }catch(err){
    console.error(err);
    fs_mostrarError('No se pudo guardar el resultado.');
  }
}

/* Exponer funciones al alcance global */
window.fs_iniciar = fs_iniciar;
window.fs_responder = fs_responder;

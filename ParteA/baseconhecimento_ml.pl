/* ========================================================================
   BASE DE CONHECIMENTO: MACHINE LEARNING (Árvore de Decisão)
   ======================================================================== */

if problema_garganta and corpo_estranho_garganta then ir_urgencia with 1.0.
if sintoma_respiratorio and vomitos_diarreia_mais_12h then consulta_sns24 with 0.9.
if sintoma_respiratorio then autocuidados with 0.8.
if convulsao then ligar_112 with 1.0.
if hemorragia_incontrolavel then ligar_112 with 1.0.
if alteracao_consciencia then ligar_112 with 1.0.
if febre_igual_superior_37_8 then ir_urgencia with 0.9.
if hemorragia_garganta_nariz_grave then ir_urgencia with 1.0.
if labios_lingua_inchados then ir_urgencia with 0.9.
if dor_garganta_e_febre_37_8 then consulta_sns24 with 0.8.
if dor_peito_costas_mal_estar then ir_urgencia with 0.9.
if dor_garganta_sem_febre then autocuidados with 0.9.
if dor_pescoco_ou_mandibula then consulta_sns24 with 0.8.
if hematoma_pescoco_crescente then ir_urgencia with 1.0.
if vomitos_diarreia_mais_12h then ir_urgencia with 0.9.

/* ========================================================================
   BASE DE CONHECIMENTO (Regras do Fluxograma)
   ======================================================================== */

% --- SECÇÃO 1: EMERGÊNCIAS (112) ---
if alteracao_consciencia                                 then ligar_112 with 1.0.
if convulsao                                             then ligar_112 with 1.0.
if engasgado_sem_tossir                                  then ligar_112 with 1.0.
if falta_ar_grave                                        then ligar_112 with 1.0.
if inchacos_labios_lingua_cara                           then ligar_112 with 1.0.
if dor_peito_mais_10min                                  then ligar_112 with 1.0.
if hemorragia_incontrolavel                              then ligar_112 with 1.0.
if falta_forca_braco or boca_ao_lado or dificuldade_falar then ligar_112 with 1.0.
if agredido_ou_acidente_24h                              then ligar_112 with 1.0.

% --- SECÇÃO 2: RAMO RESPIRATÓRIO ---
if sintoma_respiratorio and dormir_sentado_ou_cansaco_grave_avd then ir_urgencia with 0.9.
if sintoma_respiratorio and tosse_sangue_vivo then ir_urgencia with 0.9.
if sintoma_respiratorio and pieira and tratamento_inalador_sem_melhoria then ir_urgencia with 0.9.
if sintoma_respiratorio and pieira and pieira_impede_vida_normal then ir_urgencia with 0.9.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and medicamento_febre_sem_melhoria then ir_urgencia with 0.9.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and imunossuprimido then ir_urgencia with 0.9.
if sintoma_respiratorio and febre_igual_superior_37_8 and febre_ha_mais_3_dias and comorbilidade_grave then ir_urgencia with 0.9.
if sintoma_respiratorio and febre_igual_superior_37_8 and febre_ha_mais_3_dias then consulta_sns24 with 0.8.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and vomitos_diarreia_mais_12h and sinais_desidratacao then ir_urgencia with 0.9.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and vomitos_diarreia_mais_12h then consulta_sns24 with 0.8.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and vomitos_diarreia_mais_12h and sinais_desidratacao then ir_urgencia with 0.9.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and vomitos_diarreia_mais_12h then consulta_sns24 with 0.8.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and ja_iniciou_autocuidado and sintomas_ha_mais_7_dias then consulta_sns24 with 0.8.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and ja_iniciou_autocuidado then consulta_sns24 with 0.8.
if sintoma_respiratorio and alteracao_olfacto_paladar then consulta_sns24 with 0.8.
if sintoma_respiratorio then autocuidados with 0.7.

% --- SECÇÃO 3: RAMO DA GARGANTA ---
if problema_garganta and labios_lingua_inchados and dormir_sentado_ou_estridor then ir_urgencia with 0.9.
if problema_garganta and hemorragia_garganta_nariz_grave then ir_urgencia with 0.9.
if problema_garganta and hematoma_pescoco_crescente and traumatismo_recente_cavidade_oral then ir_urgencia with 0.9.
if problema_garganta and hematoma_pescoco_crescente and operacao_recente_pescoco_amigdalas and hemorragia_nao_controlavel_local then ir_urgencia with 0.9.
if problema_garganta and dor_pescoco_ou_mandibula and dor_peito_costas_mal_estar then ir_urgencia with 0.9.
if problema_garganta and dor_pescoco_ou_mandibula and dor_impede_mover_mandibula_pescoco then ir_urgencia with 0.9.
if problema_garganta and dor_pescoco_ou_mandibula and febre_dor_cabeca_nauseas_vomitos then consulta_sns24 with 0.8.
if problema_garganta and incapacidade_engolir_total then ir_urgencia with 0.9.
if problema_garganta and corpo_estranho_garganta and ingeriu_objeto_penetrante then ir_urgencia with 0.9.
if problema_garganta and corpo_estranho_garganta and engasgamento_com_liquidos then ir_urgencia with 0.9.
if problema_garganta and sinais_avc then ir_urgencia with 0.9.
if problema_garganta and garganta_pescoco_inchado_doloroso then ir_urgencia with 0.9.
if problema_garganta and (dor_garganta_e_febre_37_8 or dor_garganta_sem_febre) and vomitos_diarreia_mais_12h then ir_urgencia with 0.9.
if problema_garganta and (dor_garganta_e_febre_37_8 or dor_garganta_sem_febre) and antecedentes_febre_reumatica then ir_urgencia with 0.9.
if problema_garganta and (dor_garganta_e_febre_37_8 or dor_garganta_sem_febre) and pontos_brancos_amigdalas then consulta_sns24 with 0.8.
if problema_garganta and dor_garganta_e_febre_37_8 then consulta_sns24 with 0.8.
if problema_garganta and dor_garganta_sem_febre then autocuidados with 0.7.
if problema_garganta then autocuidados with 0.7.



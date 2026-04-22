 /* ========================================================================
   SISTEMA INTELIGENTE DE APOIO À DECISÃO - TRIAGEM SNS 24
   Projeto 1 - Parte A (Com Bónus P1MAX e Mecanismo Interativo)
   ======================================================================== */

:- dynamic fact/1.
:- dynamic justificacao/2.
:- dynamic yes/1.
:- dynamic no/1.

:- op(800, fx,   if).
:- op(700, xfx,  then).
:- op(300, xfy,  or).
:- op(200, xfy,  and).

/* ========================================================================
   1. DICIONÁRIO DE PERGUNTAS (Interface com o Utilizador)
   ======================================================================== */
% Secção 1: Emergência
pergunta(alteracao_consciencia, 'Tem alteracao de consciencia (sonolencia marcada ou nao responde)?').
pergunta(convulsao, 'Teve alguma convulsao (contracoes involuntarias do corpo)?').
pergunta(engasgado_sem_tossir, 'Esta engasgado e nao consegue tossir?').
pergunta(falta_ar_grave, 'Tem falta de ar grave (nao consegue falar ou tem uma cor azulada)?').
pergunta(inchacos_labios_lingua_cara, 'Apareceram inchacos nos labios, lingua ou cara nas ultimas 2 horas?').
pergunta(dor_peito_mais_10min, 'Tem dor no centro do peito que dura ha mais de 10 minutos?').
pergunta(hemorragia_incontrolavel, 'Tem uma perda de sangue que nao consegue controlar?').
pergunta(falta_forca_braco, 'Sente falta de forca num braco?').
pergunta(boca_ao_lado, 'Ficou com a boca ao lado?').
pergunta(dificuldade_falar, 'Tem dificuldade em falar?').
pergunta(agredido_ou_acidente_24h, 'Foi agredido ou teve um acidente nas ultimas 24 horas?').

% Secção 2 e 3: Sintomas Principais e Ramificações
pergunta(sintoma_respiratorio, 'Tem algum sintoma respiratorio como falta de ar, tosse ou congestao nasal?').
pergunta(problema_garganta, 'Tem algum problema na garganta?').
pergunta(febre_igual_superior_37_8, 'Tem temperatura igual ou superior a 37,8 graus?').
pergunta(dormir_sentado_ou_cansaco_grave_avd, 'Tem de dormir sentado ou cansaco grave em atividades devido a falta de ar?').
pergunta(tosse_sangue_vivo, 'Tem tosse com saida de sangue vivo?').
pergunta(pieira, 'Tem pieira (um som tipo apito ao respirar)?').
pergunta(medicamento_febre_sem_melhoria, 'Tomou medicamento para a febre ha mais de 2h e continua >= 37,8?').
pergunta(vomitos_diarreia_mais_12h, 'Tem vomitos ou diarreia ha mais de 12 horas?').
pergunta(dor_garganta_e_febre_37_8, 'Tem dor de garganta e febre igual ou superior a 37,8?').
pergunta(dor_garganta_sem_febre, 'Tem dor de garganta (sem febre)?').
pergunta(pontos_brancos_amigdalas, 'Tem pontos brancos nas amigdalas ou manchas na pele?').
pergunta(corrimento_nasal, 'Tem corrimento nasal?').
pergunta(nariz_entupido, 'Tem o nariz entupido?').
pergunta(dores_musculos_articulacoes, 'Tem dores nos musculos ou articulacoes?').
pergunta(alteracao_olfacto_paladar, 'Apresenta alteracao do olfato ou do paladar?').


/* ========================================================================
   2. BASE DE CONHECIMENTO (Regras do Fluxograma "Fluxo TIA.pdf")
   ======================================================================== */

% --- SECÇÃO 1: EMERGÊNCIAS (112) ---
if alteracao_consciencia                                 then ligar_112.
if convulsao                                             then ligar_112.
if engasgado_sem_tossir                                  then ligar_112.
if falta_ar_grave                                        then ligar_112.
if inchacos_labios_lingua_cara                           then ligar_112.
if dor_peito_mais_10min                                  then ligar_112.
if hemorragia_incontrolavel                              then ligar_112.
if falta_forca_braco or boca_ao_lado or dificuldade_falar then ligar_112.
if agredido_ou_acidente_24h                              then ligar_112.

% --- SECÇÃO 2: RAMO RESPIRATÓRIO ---
if sintoma_respiratorio and dormir_sentado_ou_cansaco_grave_avd then ir_urgencia.
if sintoma_respiratorio and tosse_sangue_vivo then ir_urgencia.
if sintoma_respiratorio and pieira and tratamento_inalador_sem_melhoria then ir_urgencia.
if sintoma_respiratorio and pieira and pieira_impede_vida_normal then ir_urgencia.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and medicamento_febre_sem_melhoria then ir_urgencia.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and imunossuprimido then ir_urgencia.
if sintoma_respiratorio and febre_igual_superior_37_8 and febre_ha_mais_3_dias and comorbilidade_grave then ir_urgencia.
if sintoma_respiratorio and febre_igual_superior_37_8 and febre_ha_mais_3_dias then consulta_sns24.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and vomitos_diarreia_mais_12h and sinais_desidratacao then ir_urgencia.
if sintoma_respiratorio and (febre_igual_superior_37_8 or tosse_ou_pieira) and vomitos_diarreia_mais_12h then consulta_sns24.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and vomitos_diarreia_mais_12h and sinais_desidratacao then ir_urgencia.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and vomitos_diarreia_mais_12h then consulta_sns24.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and ja_iniciou_autocuidado and sintomas_ha_mais_7_dias then consulta_sns24.
if sintoma_respiratorio and (corrimento_nasal or nariz_entupido or dores_musculos_articulacoes) and ja_iniciou_autocuidado then consulta_sns24.
if sintoma_respiratorio and alteracao_olfacto_paladar then consulta_sns24.
if sintoma_respiratorio then autocuidados.

% --- SECÇÃO 3: RAMO DA GARGANTA ---
if problema_garganta and labios_lingua_inchados and dormir_sentado_ou_estridor then ir_urgencia.
if problema_garganta and hemorragia_garganta_nariz_grave then ir_urgencia.
if problema_garganta and hematoma_pescoco_crescente and traumatismo_recente_cavidade_oral then ir_urgencia.
if problema_garganta and hematoma_pescoco_crescente and operacao_recente_pescoco_amigdalas and hemorragia_nao_controlavel_local then ir_urgencia.
if problema_garganta and dor_pescoco_ou_mandibula and dor_peito_costas_mal_estar then ir_urgencia.
if problema_garganta and dor_pescoco_ou_mandibula and dor_impede_mover_mandibula_pescoco then ir_urgencia.
if problema_garganta and dor_pescoco_ou_mandibula and febre_dor_cabeca_nauseas_vomitos then consulta_sns24.
if problema_garganta and incapacidade_engolir_total then ir_urgencia.
if problema_garganta and corpo_estranho_garganta and ingeriu_objeto_penetrante then ir_urgencia.
if problema_garganta and corpo_estranho_garganta and engasgamento_com_liquidos then ir_urgencia.
if problema_garganta and sinais_avc then ir_urgencia.
if problema_garganta and garganta_pescoco_inchado_doloroso then ir_urgencia.
if problema_garganta and (dor_garganta_e_febre_37_8 or dor_garganta_sem_febre) and vomitos_diarreia_mais_12h then ir_urgencia.
if problema_garganta and (dor_garganta_e_febre_37_8 or dor_garganta_sem_febre) and antecedentes_febre_reumatica then ir_urgencia.
if problema_garganta and (dor_garganta_e_febre_37_8 or dor_garganta_sem_febre) and pontos_brancos_amigdalas then consulta_sns24.
if problema_garganta and dor_garganta_e_febre_37_8 then consulta_sns24.
if problema_garganta and dor_garganta_sem_febre then autocuidados.
if problema_garganta then autocuidados.


/* ========================================================================
   3. MOTOR DE INFERÊNCIA (Forward Chaining Iterativo)
   ======================================================================== */

% Condição de paragem: Se já chegámos a uma conclusão, paramos de inferir (e perguntar)
terminou_triagem :- fact(ligar_112), !.
terminou_triagem :- fact(ir_urgencia), !.
terminou_triagem :- fact(consulta_sns24), !.
terminou_triagem :- fact(autocuidados), !.

demo :- terminou_triagem, !.
demo :-
    new_derived_fact(P, Cond), !,
    assert(fact(P)),
    assert(justificacao(P, Cond)),
    demo.
demo.

new_derived_fact(Concl, Cond) :-
    if Cond then Concl,
    \+ fact(Concl),
    composed_fact(Cond).

% Resolver operadores lógicos
composed_fact(Cond1 and Cond2) :- !, composed_fact(Cond1), composed_fact(Cond2).
composed_fact(Cond1 or Cond2)  :- !, (composed_fact(Cond1) ; composed_fact(Cond2)).
% Se não for operador lógico, vai perguntar ao utilizador
composed_fact(Cond) :- ask(Cond).

% Mecanismo de Pergunta: Verifica na memória antes de perguntar
ask(Cond) :- yes(Cond), !.
ask(Cond) :- no(Cond), !, fail.
ask(Cond) :-
    pergunta(Cond, Texto), !,
    nl, write('>> '), write(Texto), write(' (s/n): '),
    read(Resposta),
    ( Resposta == s -> assert(yes(Cond)) ; assert(no(Cond)), fail ).
ask(Cond) :-
    % Fallback se nos esquecermos de mapear alguma pergunta no dicionário
    nl, write('>> Tem a condicao "'), write(Cond), write('"? (s/n): '),
    read(Resposta),
    ( Resposta == s -> assert(yes(Cond)) ; assert(no(Cond)), fail ).

% Hierarquia de decisão
decisao_final(ligar_112) :- fact(ligar_112), !.
decisao_final(ir_urgencia) :- fact(ir_urgencia), !.
decisao_final(consulta_sns24) :- fact(consulta_sns24), !.
decisao_final(autocuidados) :- fact(autocuidados), !.
decisao_final(sem_decisao).


/* ========================================================================
   4. INTERFACE E SISTEMA DE EXPLICAÇÃO
   ======================================================================== */

% Limpar histórico para uma nova triagem
limpar_estado :-
    retractall(yes(_)),
    retractall(no(_)),
    retractall(fact(_)),
    retractall(justificacao(_,_)).

iniciar :-
    limpar_estado,
    nl, write('====================================================='), nl,
    write('      BEM-VINDO A TRIAGEM CLINICA SNS 24             '), nl,
    write('      (Por favor, responda com s. ou n.)             '), nl,
    write('====================================================='), nl,
    demo,
    decisao_final(D),
    nl, write('====================================================='), nl,
    write('                RESULTADO FINAL                      '), nl,
    write('====================================================='), nl,
    imprimir_decisao(D), nl,
    write('Para saber por que razao, digite: como('), write(D), write(').'), nl,
    write('====================================================='), nl.

imprimir_decisao(ligar_112) :- write('! ACAO: LIGUE 112 IMEDIATAMENTE !').
imprimir_decisao(ir_urgencia) :- write('> ACAO: Dirija-se a uma URGENCIA HOSPITALAR.').
imprimir_decisao(consulta_sns24) :- write('> ACAO: Contacte a linha SNS 24 (808 24 24 24).').
imprimir_decisao(autocuidados) :- write('> ACAO: Fique em casa com AUTOCUIDADOS.').
imprimir_decisao(sem_decisao) :- write('! O sistema nao encontrou gravidade nos sintomas.').

% Sistema de Explicação (HOW)
como(X) :-
    justificacao(X, Cond),
    nl, write('Motivo: A decisao "'), write(X), write('" foi tomada porque respondeu "Sim" a:'), nl,
    write(' -> '), write(Cond), nl.

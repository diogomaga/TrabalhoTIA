/* ========================================================================
   BASE DE DADOS: MACHINE LEARNING (Interface e Perguntas)
   ======================================================================== */

% Menu estático para as 8 perguntas da Árvore de Decisão
menu_ml :- 
    write('1. Tem alteracao de consciencia (sonolencia marcada)? (s/n): '),
    read(R1), assert(fact(alteracao_consciencia=R1)), nl,

    write('2. Tem falta de ar grave? (s/n): '),
    read(R2), assert(fact(falta_ar_grave=R2)), nl,

    write('3. Tem tosse com sangue vivo? (s/n): '),
    read(R3), assert(fact(tosse_sangue_vivo=R3)), nl,

    write('4. Tem incapacidade total de engolir? (s/n): '),
    read(R4), assert(fact(incapacidade_engolir_total=R4)), nl,

    write('5. Tem algum sintoma respiratorio? (s/n): '),
    read(R5), assert(fact(sintoma_respiratorio=R5)), nl,

    write('6. Tem febre igual ou superior a 37.8? (s/n): '),
    read(R6), assert(fact(febre_igual_superior_37_8=R6)), nl,

    write('7. Tem vomitos ou diarreia ha mais de 12 horas? (s/n): '),
    read(R7), assert(fact(vomitos_diarreia_mais_12h=R7)), nl,

    write('8. Tem dor de garganta (sem febre)? (s/n): '),
    read(R8), assert(fact(dor_garganta_sem_febre=R8)), nl,

    resultado_ml.

resultado_ml :-
    nl, write('====================================================='), nl,
    write('                RESULTADO FINAL (ML)                 '), nl,
    write('====================================================='), nl,
    findall(A, fact(A), Z),
    classify(Z, Decisao),
    imprimir_decisao_ml(Decisao), nl,
    write('====================================================='), nl.

imprimir_decisao_ml(ligar_112) :- write('! ACAO: LIGUE 112 IMEDIATAMENTE !').
imprimir_decisao_ml(ir_urgencia) :- write('> ACAO: Dirija-se a uma URGENCIA HOSPITALAR.').
imprimir_decisao_ml(consulta_sns24) :- write('> ACAO: Contacte a linha SNS 24 (808 24 24 24).').
imprimir_decisao_ml(autocuidados) :- write('> ACAO: Fique em casa com AUTOCUIDADOS.').
imprimir_decisao_ml(Class) :- write('> ACAO RECOMENDADA: '), write(Class).

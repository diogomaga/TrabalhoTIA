/* ========================================================================
   MOTOR DE INFERÊNCIA MACHINE LEARNING (Classificador da Árvore de Decisão)
   ======================================================================== */

% --- Motor de Classificação ML ---
classify(Factos, Decisao) :-
    if Condicoes then Decisao with _,
    satisfy(Factos, Condicoes),
    !.
classify(_, autocuidados).

% --- Motor de Inferência Satisfy (Parte B) ---
satisfy(Factos, Condicao) :- member(Condicao=s, Factos).
satisfy(Factos, A and B) :- satisfy(Factos, A), satisfy(Factos, B).
satisfy(Factos, A or B) :- satisfy(Factos, A) ; satisfy(Factos, B).

:- op(800, fx,   if).
:- op(700, xfx,  then).
:- op(600, xfx,  with).
:- op(300, xfy,  or).
:- op(200, xfy,  and).

/* ========================================================================
   MOTOR DE INFERÊNCIA (Forward Chaining Iterativo com Incerteza)
   ======================================================================== */

% Condição de paragem: Se já chegámos a uma conclusão com certeza > 0, paramos
terminou_triagem :- fact(ligar_112, Prob), Prob > 0, !.
terminou_triagem :- fact(ir_urgencia, Prob), Prob > 0, !.
terminou_triagem :- fact(consulta_sns24, Prob), Prob > 0, !.
terminou_triagem :- fact(autocuidados, Prob), Prob > 0, !.

demo :- terminou_triagem, !.
demo :-
    new_derived_fact(P, Cond, Prob), !,
    assert(fact(P, Prob)),
    assert(fact(justificacao(P, Cond))),
    demo.
demo.

new_derived_fact(Concl, Cond, ProbFinal) :-
    if Cond then Concl with ProbRegra,
    \+ fact(Concl, _),
    composed_fact(Cond, ProbCond),
    ProbCond > 0.0,
    ProbFinal is ProbCond * ProbRegra.

% Resolver operadores lógicos (Lógica Fuzzy / Fatores de Certeza)
composed_fact(Cond1 and Cond2, Prob) :- 
    !, 
    composed_fact(Cond1, P1), 
    composed_fact(Cond2, P2),
    Prob is min(P1, P2).

composed_fact(Cond1 or Cond2, Prob) :- 
    !, 
    (composed_fact(Cond1, P1) -> true ; P1 = 0.0),
    (composed_fact(Cond2, P2) -> true ; P2 = 0.0),
    Prob is max(P1, P2).

% Se não for operador lógico, vai perguntar ao utilizador
composed_fact(Cond, Prob) :- ask(Cond, Prob).

% Hierarquia de decisão
decisao_final(ligar_112, Prob) :- fact(ligar_112, Prob), Prob > 0.0, !.
decisao_final(ir_urgencia, Prob) :- fact(ir_urgencia, Prob), Prob > 0.0, !.
decisao_final(consulta_sns24, Prob) :- fact(consulta_sns24, Prob), Prob > 0.0, !.
decisao_final(autocuidados, Prob) :- fact(autocuidados, Prob), Prob > 0.0, !.
decisao_final(sem_decisao, 1.0).

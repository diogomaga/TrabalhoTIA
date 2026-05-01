/* ========================================================================
   SISTEMA INTELIGENTE DE APOIO À DECISÃO - TRIAGEM SNS 24
   Projeto 1 - Parte A e B
   ======================================================================== */

:- dynamic fact/1.
:- dynamic fact/2.

% Define os operadores para a Parte B
:- op(900, fx, if).
:- op(800, xfx, then).
:- op(700, xfx, with).
:- op(600, xfy, and).
:- op(500, xfy, or).

% Diz ao Prolog que a regra 'if' pode estar dividida por vários ficheiros
:- multifile (if)/1.

:- [forward, forward_ml, basedados, basedados_ml, baseconhecimento, baseconhecimento_ml].


/* ========================================================================
   INTERFACE E SISTEMA DE EXPLICAÇÃO
   ======================================================================== */

% Mecanismo de Pergunta: Verifica na memória antes de perguntar
ask(Cond, Prob) :- fact(Cond, Prob), !.
ask(Cond, Prob) :-
    pergunta(Cond, Texto), !,
    nl, write('>> '), write(Texto), write(' (s/n): '),
    read(Resposta),
    ( Resposta == s -> Prob = 1.0, assert(fact(Cond, 1.0))
    ; Prob = 0.0, assert(fact(Cond, 0.0)), fail
    ).
ask(Cond, Prob) :-
    % Fallback se nos esquecermos de mapear alguma pergunta no dicionário
    nl, write('>> Tem a condicao "'), write(Cond), write('"? (s/n): '),
    read(Resposta),
    ( Resposta == s -> Prob = 1.0, assert(fact(Cond, 1.0))
    ; Prob = 0.0, assert(fact(Cond, 0.0)), fail
    ).

% Limpar histórico para uma nova triagem
limpar_estado :-
    retractall(fact(_)),
    retractall(fact(_, _)).

iniciar :-
    limpar_estado,
    nl, write('====================================================='), nl,
    write('      BEM-VINDO A TRIAGEM CLINICA SNS 24             '), nl,
    write('====================================================='), nl,
    write('Qual o motor de triagem que deseja utilizar?'), nl,
    write('  a) Sistema Pericial (Regras Baseadas no Fluxograma)'), nl,
    write('  b) Machine Learning (Arvore de Decisao - Parte B)'), nl,
    write('>> Responda a. ou b.: '),
    read(Metodo),
    executar_metodo(Metodo).

executar_metodo(a) :-
    nl, write('--- INICIANDO SISTEMA PERICIAL (Parte A) ---'), nl,
    write('(Responda com s. ou n.)'), nl,
    demo,
    decisao_final(D, Prob),
    nl, write('====================================================='), nl,
    write('                RESULTADO FINAL                      '), nl,
    write('====================================================='), nl,
    imprimir_decisao(D, Prob), nl,
    write('Para saber por que razao, digite: porque('), write(D), write(').'), nl,
    write('====================================================='), nl.

executar_metodo(b) :-
    nl, write('--- INICIANDO MACHINE LEARNING (Parte B) ---'), nl,
    write('(Por favor, responda com s. para Sim, n. para Nao)'), nl,
    menu_ml.

executar_metodo(_) :-
    write('Opcao invalida. Tente novamente.'), nl, iniciar.


imprimir_decisao(ligar_112, Prob) :- write('! ACAO: LIGUE 112 IMEDIATAMENTE ! (Certeza: '), P is Prob * 100, write(P), write('%)').
imprimir_decisao(ir_urgencia, Prob) :- write('> ACAO: Dirija-se a uma URGENCIA HOSPITALAR. (Certeza: '), P is Prob * 100, write(P), write('%)').
imprimir_decisao(consulta_sns24, Prob) :- write('> ACAO: Contacte a linha SNS 24 (808 24 24 24). (Certeza: '), P is Prob * 100, write(P), write('%)').
imprimir_decisao(autocuidados, Prob) :- write('> ACAO: Fique em casa com AUTOCUIDADOS. (Certeza: '), P is Prob * 100, write(P), write('%)').
imprimir_decisao(sem_decisao, _) :- write('! O sistema nao encontrou gravidade nos sintomas.').

% Sistema de Explicação (HOW)
porque(X) :-
    fact(justificacao(X, Cond)),
    nl, write('Motivo: A decisao "'), write(X), write('" foi tomada porque as condicoes atingiram a certeza necessaria:'), nl,
    write(' -> '), write(Cond), nl.


:- dynamic saldo/1.
saldo(0). % Saldo inicial é 0

ver_saldo :-
    saldo(S),
    format('Seu saldo atual é: ~w~n', [S]).

depositar(Quantia) :-
    Quantia > 0,
    saldo(SaldoAtual),
    NovoSaldo is SaldoAtual + Quantia,
    retract(saldo(SaldoAtual)),
    asserta(saldo(NovoSaldo)),
    format('Você depositou ~w. Seu novo saldo é: ~w~n', [Quantia, NovoSaldo]).

sacar(Quantia) :-
    Quantia > 0,
    saldo(SaldoAtual),
    Quantia =< SaldoAtual,
    NovoSaldo is SaldoAtual - Quantia,
    retract(saldo(SaldoAtual)),
    asserta(saldo(NovoSaldo)),
    format('Você sacou ~w. Seu novo saldo é: ~w~n', [Quantia, NovoSaldo]).

sacar(_) :-
    write('Saldo insuficiente para realizar o saque!'), nl.

calcular_juros(Principal, JurosAnuais, Periodo, Montante) :-
    Montante is Principal * (1 + JurosAnuais / 100) ^ Periodo.

pegar_emprestimo(Principal) :-
    JurosAnuais = 8,
    Periodo = 1,
    calcular_juros(Principal, JurosAnuais, Periodo, MontanteTotal),
    saldo(SaldoAtual),
    format('Empréstimo de ~w concedido. Com juros de ~w%, o valor total a pagar será: ~2f~n', [Principal, JurosAnuais, MontanteTotal]),
    NovoSaldo is SaldoAtual + Principal ,
    retract(saldo(SaldoAtual)),
    asserta(saldo(NovoSaldo)),
    format('Seu novo saldo é: ~2f~n', [NovoSaldo]).

% Adiciona uma interface simples para interagir com o programa
iniciar :-
    write('Bem-vindo à Conta Corrente!'), nl,
    write('Escolha uma opção:'), nl,
    write('1. Ver Saldo'), nl,
    write('2. Depositar'), nl,
    write('3. Sacar'), nl,
    write('4. Pegar Empréstimo'), nl,
    write('5. Sair'), nl,
    read(Opcao),
    executar(Opcao).

executar(1) :-
    ver_saldo,
    iniciar.
executar(2) :-
    write('Digite a quantia para depositar: '), read(Quantia),
    depositar(Quantia),
    iniciar.
executar(3) :-
    write('Digite a quantia para sacar: '), read(Quantia),
    sacar(Quantia),
    iniciar.
executar(4) :-
    write('Digite a quantia do empréstimo: '), read(Quantia),
    pegar_emprestimo(Quantia),
    iniciar.
executar(5) :-
    write('Saindo do programa. Obrigado!'), nl.
executar(_) :-
    write('Opção inválida! Tente novamente.'), nl,
    iniciar.
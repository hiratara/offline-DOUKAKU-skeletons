% ストリームから読み込んだコンテンツを第1引数に束縛する
read_contents(Cs) :-
    get_code(C),
    read_contents(C, Cs).

read_contents(-1, []). % ストリームの終端検出（get_code は -1 を返す）
read_contents(C, [C|Cs]) :-
    C > 0, 
    read_contents(Cs).

% 第1引数の要素（区切り文字）で第2引数のリストを分割した結果のリストのリストを第3引数に束縛する
split(_, [], [[]]).
split(C, [C], [[]]) :- !. % 末尾の区切り文字は無視する
split(C, [X|Xs], [[X|Zs]|Ys]) :-
    C \== X,
    split(C, Xs, [Zs|Ys]).
split(C, [C|Xs], [[]|Ys]) :-
    split(C, Xs, Ys).

% リストを改行文字（文字コード 10）で分割する
lines(Xs, Ys) :- split(10, Xs, Ys).

% リストをタブ文字（文字コード 9）で分割する
words(Xs, Ys) :- split(9, Xs, Ys).

% テストを実行し、合否の結果のリストを第2引数に束縛する
test([Name, Input, Expected|_], R) :-
  solve(Input, Actual),
  report(Name, Actual, Expected, R).

% テスト結果をレポートする
report(_, Expected, Expected, success).
report(Name, Actual, Expected, failure) :-
    Actual \== Expected, 
    format("Failure in ~s~nexpected: ~s~n  actual: ~s~n", [Name, Expected, Actual]).

% テスト結果のリスト中の失敗の数を第2引数に束縛する
count_failure([], 0).
count_failure([R|Rs], C) :-
    count_failure(Rs, C1),
    (R == failure -> C is C1 + 1; C is C1).

tests :-
    consult('answer.prolog'),    % 解答プログラムを読み込む
    see('patterns.tsv'),         % テストパタンのファイルを開く
    read_contents(Cs),           % ファイルの内容をCsに束縛する
    seen,                        % ファイルを閉じる
    lines(Cs, Ls),               % 内容を行に分割しLsに束縛する
    maplist(words, Ls, Ps),      % 各行を入力パタンに分割し、結果のリストをPsに束縛する
    maplist(test, Ps, Rs),       % 各入力パタンをテストし、結果のリストをRsに束縛する
    length(Rs, Cases),           % 実施したテストケースの総数をCasesに束縛する
    count_failure(Rs, Failures), % 失敗したテストケースの総数をFailuresに束縛する
    format("~nCases: ~d  Failures: ~d~n", [Cases, Failures]).

% If using SWI-Prolog …
%
% $ swipl -s test.prolog -g tests -t halt
% Failure in #2
% expected: 13245
%   actual: 12345
% 
% Cases: 3  Failures: 1

% If using GNU-Prolog …
%
% $ gprolog --consult-file test.prolog --entry-goal 'tests, halt'
% Failure in #2
% expected: 13245
%   actual: 12345
% 
% Cases: 3  Failures: 1

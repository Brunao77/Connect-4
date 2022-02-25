 */

concatenar([], Xs, Xs).
concatenar([X|Xs], Y, [X|Zs]):- concatenar(Xs, Y, Zs).

conecta4(T,F,LP):-
    contenido(T,[H,C],F),
    C1 is C+1, C2 is C+2, C3 is C+3,
    contenido(T,[H,C1],F),
    contenido(T,[H,C2],F),
    contenido(T,[H,C3],F),
    concatenar([],[[H,C],[H,C1],[H,C2],[H,C3]],LP).
conecta4(T,F,LP):-
    contenido(T,[H,C],F),
    H1 is H+1, H2 is H+2, H3 is H+3,
    contenido(T,[H1,C],F),
    contenido(T,[H2,C],F),
    contenido(T,[H3,C],F),
    concatenar([],[[H,C],[H1,C],[H2,C],[H3,C]],LP).
conecta4(T,F,LP):-
    contenido(T,[H,C],F),
    H1 is H+1, H2 is H+2, H3 is H+3,
    C1 is C+1, C2 is C+2, C3 is C+3,
    contenido(T,[H1,C1],F),
    contenido(T,[H2,C2],F),
    contenido(T,[H3,C3],F),
    concatenar([],[[H,C],[H1,C1],[H2,C2],[H3,C3]],LP).
conecta4(T,F,LP):-
    contenido(T,[H,C],F),
    H1 is H-1, H2 is H-2, H3 is H-3,
    C1 is C+1, C2 is C+2, C3 is C+3,
    contenido(T,[H1,C1],F),
    contenido(T,[H2,C2],F),
    contenido(T,[H3,C3],F),
    concatenar([],[[H,C],[H1,C1],[H2,C2],[H3,C3]],LP).
conecta4(T,F,LP):-
    contenido(T,[H,C],F),
    H1 is H+1, H2 is H+2, H3 is H+3,
    C1 is C-1, C2 is C-2, C3 is C-3,
    contenido(T,[H1,C1],F),
    contenido(T,[H2,C2],F),
    contenido(T,[H3,C3],F),
    concatenar([],[[H,C],[H1,C1],[H2,C2],[H3,C3]],LP).
conecta4(T,F,LP):-
    contenido(T,[H,C],F),
    H1 is H-1, H2 is H-2, H3 is H-3,
    C1 is C-1, C2 is C-2, C3 is C-3,
    contenido(T,[H1,C1],F),
    contenido(T,[H2,C2],F),
    contenido(T,[H3,C3],F),
    concatenar([],[[H,C],[H1,C1],[H2,C2],[H3,C3]],LP).

/* 
 * 6) empate(Tablero) Tablero unifica con un tablero que no tiene ganador 
 * y ninguna columna disponible para ingresar fichas. 
 * 
 */  
empate(T):- not(columnaDisp(T,_E)),
            not(conecta4(T,a,_LA)), 
    		not(conecta4(T,b,_LB)).
/*
 *  7) jugadaGanadora(Tablero,Ficha,Columna)  
 * Tablero unifica con un tablero, Ficha con una ficha y Columna 
 * con la columna sobre la cual ingresar una ficha que gane el juego. 
 * Si no existe un movimiento para ganar el juego el predicado falla
 * 
 */
jugadaGanadora(T,F,C):-
    columnaDisp(T,C),
    not(conecta4(T,F,_)),
    ingresarFicha(T,C,F,T2),
    conecta4(T2,F,_).
/*
 * 8) jugadaSegura(Tablero,Ficha,Columna) Tablero unifica con un tablero, 
 * Ficha con una ficha y Columna con la columna sobre la cual ingresar una ficha 
 * garantizando que no se habilita una jugada ganadora al oponente
 * 
 */
jugadaSegura(T,a,C):-
    ingresarFicha(T,C,a,T2),
    not(jugadaGanadora(T2,b,_)).
jugadaSegura(T,b,C):-
    ingresarFicha(T,C,b,T2),
    not(jugadaGanadora(T2,a,_)).
/*
 * 9) jugadaDefinitiva(Tablero,Ficha,Columna) Tablero unifica con un tablero, 
 * Ficha con una ficha y Columna con la columna sobre la cual ingresar una ficha 
 * que garantice ganar el juego en el próximo turno sin importar el movimiento 
 * del oponente
 * 
 */
jugadaDefinitiva(T,a,C):-
    ingresarFicha(T,C,a,T2),
    not(jugadaSegura(T2,b,_)).
jugadaDefinitiva(T,b,C):-
    ingresarFicha(T,C,b,T2),
    not(jugadaSegura(T2,a,_)).
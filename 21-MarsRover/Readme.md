# Decisiones de diseño

A la hora de implementar una instruccion valida, estabamos en la duda si mars rover deberia moverse o no, si en algun momento de la cadena de instrucciones, recibe una instruccion invalida.
Consultamos en clase a un ayudante, y nos dijo que podiamos tomar la decision que queramos, ya sea que se mueva hasta la instruccion invalida, o que permanezca en la posicion que estaba.
Tomamos la decision de no mover a mars rover en caso de encontrar una instruccion invalida.
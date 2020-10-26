A = input("Introduzca la matriz: \n");
b = input("Introduzca el vector de términos independientes: \n");

n = size(A,1);
v = 1 : n;

for j = 1 : n-1
    % Buscamos el pivote
    [pivote, pos] = max(abs(A(v(j:n),j)));
    
    % Si la matriz no es inversible mostramos error
    if (pivote == 0)
        error("ERROR: La matriz no es inversible");
    end  
    
    % Permutamos filas en el vector auxiliar
    [v(pos+j-1), v(j)] = deal(v(j),v(pos+j-1)); 
    
    % Dividimos entre el pivote
    for k = j+1:n
        A(v(k),j) = A(v(k),j) / A(v(j),j);
    end  
    
    % Hacemos la operación que nos indican los elementos de las columnas
    for k = j+1 : n
        A(v(k),j+1:n) = A(v(k),j+1:n) - A(v(k),j) * A(v(j),j+1:n);
    end
end

% Calculamos w con método de remonte
w = triangularInferior(A, b, v);

% Calculamos u con método de remonte
u = triangularSuperior(A, w, v);

% Mostramos la solución
fprintf("La solución es: \n");
fprintf("%d \n",u);

% Preguntamos si el usuario quiere resolver más sistemas
p = input("¿Desea resolver otro sistema con esta matriz?\n 1 - SI\n 2 - NO\n");
while(p == 1)
        b = input("Introduzca el vector de términos independientes: \n");
        
        % Calculamos w con método de remonte
        w = triangularInferior(A, b, v);
        
        % Calculamsos u con método de remonte
        u = triangularSuperior(A, w, v);
        
        % Mostramos la solución
        fprintf("La solución es u = %d \n",u);
        fprintf("%d \n",u);
        
        p= input("¿Desea resolver otro sistema con esta matriz?\n 1 - SI\n 2 - NO\n");
end

% Método de remonte de una matriz triangular inferior
function u = triangularInferior(A, b, v)
    n = size(A, 1);
    u = zeros(n, 1);

    for i = 1 : n
        u(i) = b(v(i)) - A(v(i), 1: i-1) * u(1:i-1);
    end
end

% Método de remonte de una matriz triangular superior
function u = triangularSuperior(A, b, v)
    n = size(A, 1);
    u = zeros(n, 1);

    for i = n :-1: 1
        u(i) = ( b(i) - A(v(i), i+1:n) * u(i+1:n) ) / A(v(i),i);
    end
end
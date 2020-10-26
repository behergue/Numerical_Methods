A = input("Introduzca la matriz: \n");
b = input("Introduzca el vector de t�rminos independientes: \n");

n = size(A, 1);

for i = 1 : n
    % Calculamos los elementos de la diagoal de U
    A(i,i) = A(i,i) - (A(i, 1 : i-1) * A(1 : i-1, i));
    
    % Si la factorizaci�n LU no es posible mostramos error
    if A(i, i) == 0
        error("ERROR: La matriz no admite factorizaci�n LU");
    end
    
    % Calculamos el resto de elementos de U
    for k = i+1: n
    	A(i, k) = A(i, k) - (A(i, 1 : i-1) * A (1 : i-1, k));
    end
    
    % Calculamos los elementos de L
    for k = i+1:n
    	A(k,i) = (A(k,i) - (A(k, 1 : i-1) * A(1 : i-1, i))) / A(i,i);
    end
end

% Calculamos w con el m�todo de remonte
w = triangularInferior(A, b);
% Calculamos u con el m�todo de remonte
u = triangularSuperior(A, w);

% Mostramos la soluci�n
fprintf("La soluci�n es: \n");
fprintf("%d \n",u);

% Preguntamos si el usuario quiere resolver m�s sistemas
p = input("�Desea resolver otro sistema con esta matriz?\n 1 - SI\n 2 - NO\n");
while(p == 1)
        b = input("Introduzca el vector de t�rminos independientes: \n");

        % Calculamos de w con el m�todo de remonte
        w = triangularInferior(A, b);
        
        % Calculamos de u con el m�todo de remonte
        u = triangularSuperior(A, w);
        
        % Mostramos la soluci�n
        fprintf("La soluci�n es: \n");
        fprintf("%d \n",u);

        p = input("�Desea resolver otro sistema con esta matriz?\n 1 - SI\n 2 - NO\n");
end

% M�todo de remonte de una matriz triangular inferior
function u = triangularInferior(A, b)
    n = size(A,1);
    u = zeros(n, 1);

    for i = 1 : n
        u(i) = b(i) - (A(i, 1: i-1) * u(1:i-1));
    end
end

% M�todo de remonte de una matriz triangular superior
function u = triangularSuperior(A, b)
    n = size(A,1);
    u = zeros(n, 1);

    for i = n :-1: 1
        u(i) = ( b(i) - (A(i, i+1:n) * u(i+1:n)) ) / A(i,i) ;
    end
end

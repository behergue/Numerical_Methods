n = input("Introduzca el tama�o de la matriz: \n");

A = zeros(n, n);

% Pedimos media matriz puesto que debe de ser sim�trica o herm�tica
for i = 1 : n
    fprintf("Introduzca la fila %d de [%d..n]", i, i);
    A(i, i:n) = input(" de la matriz del sistema: \n");
    A(i+1:n, i) = A(i, i+1:n);
end

b = input("Introduzca el vector de t�rminos independientes: \n");

for i = 1:n
    A(i,i) = A(i,i) - dot(A(i, 1:i-1), A(i, 1:i-1));
    
    if (A(i,i) <= 0)
        error("ERROR: La matriz no admite factorizaci�n de Cholesky");
    end
    
    A(i,i) = sqrt(A(i,i));
    
    for j = i+1:n
        A(j,i) = (A(i,j) - dot(A(i, 1:i-1),A(j, 1:i-1)))/A(i,i);
    end
end

% Calculamos w con el m�todo de remonte
w = triangularInferior(A, b);
% Calculamos u con el m�todo de remonte
u = triangSupCholesky(A', w);

% Mostramos la soluci�n
fprintf("La soluci�n es: \n");
fprintf("%d \n",u);

% Preguntamos si el usuario quiere resolver m�s sistemas
p = input("�Desea resolver otro sistema con esta matriz?\n 1 - SI\n 2 - NO\n");
while(p == 1)
    b = input("Introduzca el vector de t�rminos independientes: \n");
    
    % Calculamos w con el m�todo de remonte
    w = triangularInferior(A, b);
    % Calculamos u con el m�todo de remonte
    u = triangSupCholesky(A', w);

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
        u(i) = ( b(i) - A(i, 1: i-1) * u(1:i-1) ) / A(i,i);
    end
end

% M�todo de remonte de una matriz triangular superior
% con la peculiaridad de que lo resolvemos para la traspuesta
function u = triangSupCholesky(A, b)
    n = size(A,1);
    u = zeros(n, 1);
    
    for i = n :-1: 1
        u(i) = ( b(i) - A(i, i+1:n) * u(i+1:n) ) / A(i,i) ;
    end
end

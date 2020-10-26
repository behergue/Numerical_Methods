b = input("Introduzca la diagonal principal: \n");
c = input("Introduzca la diagonal superior: \n");
a = input("Introduzca la diagonal inferior: \n");
d = input("Introduzca el vector de términos independientes: \n");

% Calculamos x con el método de remonte
x = remonteTriDiagonal(a, b, c, d);

% Mostramos la solución
fprintf("La solución es: \n");
fprintf("%d \n", x);

% Preguntamos si el usuario quiere resolver más sistemas
p = input("¿Desea resolver otro sistema con esta matriz?\n 1 - SI\n 2 - NO\n");
while(p == 1)
    d = input("Introduzca el vector de términos independientes: \n");
   
    % Calculamos x con el método de remonte
    x = remonteTriDiagonal(a, b, c, d);
    
    % Mostramos la solución
    fprintf("La solución es: \n");
    fprintf("%d \n", x);
    
    p = input("¿Desea resolver otro sistema con esta matriz?\n 1 - SI\n 2 - NO\n");
end

function x = remonteTriDiagonal(a,b,c,d)
    n = length(b);
    m = zeros(n, 1);
    g = zeros(n, 1);
    
    m(1) = b(1);
    if m(1) == 0
        error("ERROR: La matriz A no tiene todos sus menores principales distintos de cero");
    end
    
    g(1) = d(1) / m(1);
    for k = 2:n
        
        m(k) = b(k) - c(k-1) / m(k-1) * a(k-1);
        if m(k) == 0
            error("ERROR: La matriz A no tiene todos sus menores principales distintos de cero");
        end
        
        g(k) = (d(k) - g(k-1) * a(k-1)) / m(k);
    end

    x(n) = g(n);
    for k = n-1:-1:1
        x(k) = g(k) - c(k) / m(k) * x(k+1);
    end
end

% Beatriz Herguedas Pinedo

A = input("Introduzca la matriz: \n");
n = size(A, 1);

if size(A, 2) ~= n
    error("ERROR: La matriz no es cuadrada\n");
end

 for i = 1:n
    if A(i,i) == 0
        error("ERROR: No puede haber ceros en la diagonal\n");
    end
 end 

b = input("Introduzca el vector de términos independientes: \n");
b = b(:);

if length(b) ~= n
    error("ERROR: Las dimensiones de b no coinciden con las de la matriz");
end

w = input ("Introduzca el factor de peso: \n");
it = input("Introduzca el número máximo de iteraciones: \n");
p = input("Introduzca la precisión de cálculo: \n");

% Inicializaciones
d = zeros(n, 1);
r = zeros(n, 1);
u_k = zeros(n, 1);
v_precisiones = [];

for k = 1 : it
    
    for i = 1: n
        r(i) = b(i) - A(i,1:i-1)*u_k(1:i-1) - A(i, i:n)*u_k(i:n);
        d(i) = w*(r(i)/A(i, i));
        u_k(i) = u_k(i) + d(i);
    end
    
    % Test de parada: ||r^k|| < precision ||b||
    v_precisiones(k) = norm(r)/norm(b);
    
    % Si el test de parada nos indica que hemos alcanzado la precisión
    % deseada
    if v_precisiones(k) < p
        iteraciones = 1:length(v_precisiones);
        
        % Lo sacamos por pantalla
        fprintf("Se ha alcanzado la precisión deseada\n");
        fprintf("La solución aproximada tras la iteracion %d \n", iteraciones(end))
        fprintf(" es u = %d \n",u_k);
        
        % Y representamos la precisión
        plot(iteraciones, v_precisiones);
        
        break;
    end
end

if(k == it) 
    fprintf("Se han agotado las iteraciones\n");
    fprintf("El valor alcanzado es u = %d \n",u_k);
end

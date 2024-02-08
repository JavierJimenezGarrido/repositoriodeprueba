︠d0f345ac-ab7b-4381-903f-ce5249a8efe2  (Deberías quitar esto)
    n = 4 # numero de neuronas ESTO IRÍA FUERA
    m = 5 # número de palabras en el código
    GF2 = FiniteField(2)
    M=MatrixSpace(GF2,m,n)
    R = PolynomialRing(GF2, ['x%s'%i for i in rangen)])
    ci= vector(R,C[i-1])
    CF_JCi= [R.gen(j)-ci[j]for j in range(n)] # Paso 1
    C = M([[1, 0, 0, 0], [0, 1, 0, 0], [1, 1, 0, 0], [0, 1, 0, 1], [1, 0, 1, 0]])
    C
    i = 1
    while i < n:
        i = i + 1
        Mi = [f * (R.gen(j)-ci[j])  for f in CF_JCi for j in range(n)] #PASO2
        Mi_prima = [expr.reduce_trig() for expr in Mi]  # Paso 3
        Mi_tilde = [expr for expr in Mi_prima if not any(expr.is_multiple_of(elem) for elem in Mi_prima if expr != elem)]  # Paso 4
        CF_JCi = Mi_tilde
CF_JCi







︡b66b556e-5850-4308-8115-5fb8ebc976d1︡{"stdout":"[1 0 0 0]\n[0 1 0 0]\n[1 1 0 0]\n[0 1 0 1]\n[1 0 1 0]\n"}︡{"stderr":"Error in lines 0-11\nTraceback (most recent call last):\n  File \"/cocalc/lib/python3.11/site-packages/smc_sagews/sage_server.py\", line 1245, in execute\n    compile(block + '\\n',\n  File \"<string>\", line 1\n    while i < n:\n                ^\nIndentationError: expected an indented block after 'while' statement on line 1\n"}︡{"done":true}
︠c46dc296-81fe-4cf3-878f-e9b870967d98︠
def forma_canonica(n,m,codigo):
    """
    Una función que toma dos números enteros y un conjunto de vectores como entrada.

    Input:
        n (int): Número de neuronas.
        m (int): Número de àlabras código.
        codigo (list): Conjunto de vectores que forman el código.

    Return:
        tuple: Una tupla con dos elementos.  Conjunto de polinomios que forman la forma canónica del ideal                         neuronal y el ideal neuronal
    """
    GF2 = FiniteField(2)
    M=MatrixSpace(GF2, m, n)
    R = PolynomialRing(GF2, ['x%s'%i for i in range(1,n+1)])
    C = M(codigo)  #Matriz compuesta por las palabras código en filas
    ci = vector(R, C[0]) #Palabra c1
    CF_JCi = [R.gen(j)-ci[j] for j in range(n)] # PASO 1
    i = 1

    while i < m:
        i = i + 1
        Mi = [f * (R.gen(j)- vector(GF2,C[i-1])[j]) for j in range(n)for f in CF_JCi] # PASO2
        S=[R.gen(j)^2-R.gen(j) for j in range (n)]
        A=[R.gen(j)^2  for j in range(n)]
        B=[(R.gen(k)-1)^2 for k in range(n)]
        Mi_prima1=[]
        #PASO 3
        for f in Mi:
            es_nulo = False
            for g in S:
                if g.divides(f):
                    Mi_prima1.append(0)
                    es_nulo = True
                    break  # Salir del bucle interno si encontramos un g que divide f
            if not es_nulo:
                Mi_prima1.append(f)
        Mi_prima2=[f for f in Mi_prima1 if  f !=0 ]
        Mi_prima=[]
        for f in Mi_prima2:
            divisible_por_g = False
            for g in A + B:
                if g.divides(f):
                    Mi_prima.append(f//sqrt(g))
                    divisible_por_g = True
                    break  # Salir del bucle interno si encontramos un g que divide f
            if not divisible_por_g:
                Mi_prima.append(f)
        Mi_tilde=list(set([f for f in Mi_prima if not any(g.divides(f) for g in Mi_prima if f!=g)]))#PASO 4
        CF_JCi=Mi_tilde #vuelta al PASO 2
        JC=R.ideal(CF_JCi)#ideal neuronal
    return CF_JCi, JC
#JC=R.ideal(CF_JCi) #ideal neuronal

︡e6141923-da3b-4ddd-b9a8-e95afb67cc78︡{"done":true}
︠757b610f-7320-4f2a-95d1-95755486f8d8︠

︡efa22073-9018-4e6d-9658-fad6fd1310d4︡
︠f59e0066-16c6-4a7c-8d7a-77272050d105︠

︡3952ba57-c776-4742-8b0b-10f07ab620df︡{"done":true,"error":"killed"}︡
︠a92baea0-07c7-4c40-a0a5-2c063ba6dbf3s︠
forma_canonica(4,5,[[1, 0, 0, 0], [0, 1, 0, 0], [1, 1, 0, 0], [0, 1, 0, 1], [1, 0, 1, 0]])

︡78906efd-a999-4c4a-abd2-12b4cdd291e1︡{"stdout":"([x3*x4, x1*x3 + x3, x2*x4 + x4, x1*x2 + x1 + x2 + 1, x2*x3, x1*x4], Ideal (x3*x4, x1*x3 + x3, x2*x4 + x4, x1*x2 + x1 + x2 + 1, x2*x3, x1*x4) of Multivariate Polynomial Ring in x1, x2, x3, x4 over Finite Field of size 2)\n"}︡{"done":true}
︠1216ed55-bb00-4387-8c24-b4200aa4dda9s︠
forma_canonica(4,5,[[1,0,0,0,],[0,1,0,0],[1,1,0,0],[0,1,1,0],[0,1,1,1]])
︡057555a5-aaf2-46e8-bfb8-f30542d3b152︡{"stdout":"([x2*x3 + x3, x1*x3, x3*x4 + x4, x2*x4 + x4, x1*x2 + x1 + x2 + 1, x1*x4], Ideal (x2*x3 + x3, x1*x3, x3*x4 + x4, x2*x4 + x4, x1*x2 + x1 + x2 + 1, x1*x4) of Multivariate Polynomial Ring in x1, x2, x3, x4 over Finite Field of size 2)\n"}︡{"done":true}
︠6fdb5587-7314-418b-8ba8-a90fa8028d70s︠
forma_canonica(4,11,[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1],[1,1,0,0],[0,1,1,0],[1,0,0,1],[0,0,1,1],[1,0,1,0],[1,1,1,0],[1,0,1,1]])
︡5cc102da-d267-4142-8ded-ae5321e87115︡{"stdout":"([x1*x2*x3*x4 + x1*x2*x3 + x1*x2*x4 + x1*x3*x4 + x2*x3*x4 + x1*x2 + x1*x3 + x2*x3 + x1*x4 + x2*x4 + x3*x4 + x1 + x2 + x3 + x4 + 1, x2*x4], Ideal (x1*x2*x3*x4 + x1*x2*x3 + x1*x2*x4 + x1*x3*x4 + x2*x3*x4 + x1*x2 + x1*x3 + x2*x3 + x1*x4 + x2*x4 + x3*x4 + x1 + x2 + x3 + x4 + 1, x2*x4) of Multivariate Polynomial Ring in x1, x2, x3, x4 over Finite Field of size 2)\n"}︡{"done":true}
︠a662b7cb-48a4-4f26-9821-cdf0537f693ds︠
forma_canonica(4,6,[[1,0,0,0],[0,1,0,0],[0,1,1,0],[1,0,1,0],[1,1,1,0],[1,1,1,1]])
︡746bc4c3-d467-494c-912f-ab08e2e2b316︡{"stdout":"([x1*x4 + x4, x3*x4 + x4, x1*x2*x3 + x1*x2, x2*x4 + x4, x1*x2 + x1 + x2 + 1], Ideal (x1*x4 + x4, x3*x4 + x4, x1*x2*x3 + x1*x2, x2*x4 + x4, x1*x2 + x1 + x2 + 1) of Multivariate Polynomial Ring in x1, x2, x3, x4 over Finite Field of size 2)\n"}︡{"done":true}










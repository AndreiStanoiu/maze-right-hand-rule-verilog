Stanoiu Andrei 334AB 

Am folosit 2 variabile: driectie_deplasare si loc_apropiere pe care am aplicat latch sa salvez valorile de deplasare si de pozitie invecinata cu personajul.
Variabila initializat am folosit-o pentru a stabili daca am initializat pozitia de inceput a personajului. Valoarea ei este modificata pe frontul crescator
de ceas. Aceasta variabila are valoarea 0 doar la inceput, dupa primul ceas are mereu 1.

Variabila continua este folosita pentru a asigura continuitatea intrarii in always pentru parcurgerea prin labirint a personajului.
If-ul de la linia 46 si 47 este pentru a folosi variabila "continua" si astfel a asigura continuitatea programului. Variabila este modificata mereu la fiecare ciclu.

Variabilele row_ajutator si col_ajutator sunt folosite pentru a salva pozitia personajului iar de row si col ma folosesc sa verific pozitiile si sa scriu conform configuratiei
date al circuitului.
citire_sau_verificare are 2 valor pe care le-am definit cu ajutorul `define-urilor, astfel daca sunt in starea de "citire" atunci citesc urmatoarea pozitie dupa care trec in starea
de verificare sa verific acea stare folosind semnalul de intrare maze_in. 

Pentru fiecare caz (de citire sau de scriere) verific atat directia de deplasare cat si pozitia din jurul personajului deoarece variabilele citire_fata, citire_dreatpa, citire_spate
si citire_stanga sunt relative la personaj. Algoritmul implementat este cel de urmarire mereu a peretelui din dreapta. Daca acea pozitie nu este marcata cu 0 atunci se continua in sens
trigonometric. Daca pozitia este valida, este marcata cu 1 si dupa se continua verificarile.
La fiecare pas am mai inti citirea si dupa verificarea.
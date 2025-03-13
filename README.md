# Imer_YH24
Detta projekt innehåller en SQL fil med en databaskod för en liten bokhandel. Repositoryn innehåller även ett ER-diagram som visar relationer.
* Kunder - Beställningar (1:M):
Relation: En kund kan göra flera beställningar, men en beställning tillhör bara en kund
Implementering: KundID som främmande nyckel i Beställnigar.

* Beställningar - Orderrader (1:M):
Relation: En beställning kan innehålla flera orderrader, men varje orderrad tillhör bara en beställning.
Implementering: Ordernummer som främmande nyckel i Orderrader.

* Böcker - Orderrader (1:M):
Relation: En bok kan förekomma i flera orderrader, men varje orderrader refererar till en specifik bok.
Implementering: ISBN som främmande nyckel i Orderrader.




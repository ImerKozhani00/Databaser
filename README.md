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

* Kunder - Logg (1:):
  Relation: En kund kan ha många loggposter, men varje loggpost tillhör endast en kund
  Implementering: KundID som främmande nyckel i Logg


Reflektion över databasen  

* Designval  
Databasen är normaliserad (3NF) för att minimera redundans och säkerställa dataintegritet.
Relationerna mellan tabellerna gör det möjligt att hantera kunder, beställningar och böcker effektivt.  

* Skalbarhet (100 000 kunder)  
För att hantera en större datamängd kan vi optimera prestandan genom indexering på sökbara fält (t.ex. e-post och datum).
Partitionera beställningar efter år och använda sharding för att sprida datan över flera servrar.  

* Optimeringar  
Vi kan förbättra databasen genom att använda caching för vanliga sökfrågor-
Dessutom materialiserade vyer för rapportering samt effektiva index och constraints för att snabba upp SQL-frågor.  

Dessa åtgärder gör databasen både skalbar och responsiv även vid hög belastning.  




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

* Kunder - Logg (1:M):
Relation: En kund kan ha många loggposter, men varje loggpost tillhör endast en kund.
Implementering: KundID som främmande nyckel i Logg


Reflektion över databasen  

* Designval  
Databasen är normaliserad (3NF) för att minimera redundans och säkerställa dataintegritet.
Det innebär att varje kolumn endast lagrar en enda typ av information och att alla icke-nyckelattribut är beroende av hela primärnyckeln.
Relationerna mellan tabellerna gör det möjligt att hantera kunder, beställningar och böcker effektivt.  

* Skalbarhet (100 000 kunder)
För att hantera en större datamängd kan prestandan optimeras genom indexering på sökbara fält, som till exempel e-post och datum. 
E-post gör det snabbare att söka efter kunder, medan datum förbättrar hastigheten för att hämta beställningar per tidsperiod.
Sharding skulle kunna användas för att sprida data över flera servrar, vilket skulle kunna minska risken för att en specifik server blir överbelastad.
En annan metod som kan tillämpas är partitionering av tabellen "Beställningar", där kriteriet skulle kunna vara "År", vilket gör att äldre data kan hanteras separat och förbättrar prestandan.

* Optimeringar  
Caching: För att minska belastningen på databasen vid återkommande frågor.
Materialiserade vyer: För att spara ofta använda frågor och minska belastningen på databasen.
Index och constraints: För att snabba upp sökningar och förhindra felaktig data. 

Dessa åtgärder gör databasen både skalbar och responsiv även vid hög belastning.  




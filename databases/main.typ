#set page(margin: (x: 1.5cm, y: 2cm))
#align(center)[#text(size: 20pt)[ESYBIŲ RYŠIŲ MODELIS]]
#v(2em)

#show image: set align(center)
#show link: underline
#show link: set text(rgb("#0000C0"))
#show heading: it => {
    set align(center)
    set text(weight: "regular")
    underline(it)
    v(1em)
}

// #let marker(text, color: rgb("#ffdfe7C0")) = {
//     box(fill: color, outset: (x: 2pt, y: 3pt), radius: 2pt)[#text]
// }
// 
// #let emph = the_text => {
//   box(height: 1em)[#place(left + bottom, dx:  0.5pt, dy: -0.5pt, text(fill: rgb("#ffcfc7"), weight: "bold")[#the_text])]
//   box(height: 1em)[#place(left + bottom, dx: -0.5pt, dy:  0.5pt, text(fill: rgb("#c0cff7"), weight: "bold")[#the_text])]
//   text(weight: "bold", the_text)
// }

// Tekstas #emph("tekstas...") toliau...

= Esybės

*Esybė* -- susijusios informacijos rinkinėlis. 
Pati esybė yra tik informacijos aprašymas/specifikacija. \
Python'e esybes atitinka klasės.

*Esybės egzempliorius* yra jau realūs, 
konkretūs duomenys sugrupuoti pagal kažkokią esybę. \
Python'e egzempliorius atitinka objektai.

*Atributai* yra arba esybių, arba egzempliorių dalys, 
kurių daugiau suskaidyti neišeina: skaičiai, tekstas ir t.t. \
Python'e atributus atitinka klasių kintamieji.

#image("example3.png")

Taisyklės:
+ Atributai negali būti sąrašais. (tam yra vienas-su-daug ryšiai)
+ Esybių pavadinimai yra vienaskaita (nebent neleidžia lietuvių kalba)
+ Microsoft Visio, po pirminiais raktais (kažkodėl) turi būti punktyrinė linija...

#pagebreak()

= Ryšiai

*Ryšys* -- šizofrenijos priepuolis?.. nežinau... Šiaip, ryšiai reiškia, 
kad pagal vienos esybės egzempliorių galima gauti kitų esybių egzempliorius.

*Pirminis raktas (PK)* -- vienas ar daugiau atributų, 
pagal kuriuos galima atskirti egzempliorius.

Pirminis raktas gali būti „dirbtinis“ (tiesiog kodas/numeris),
arba susidaryti iš jau esančių atributų, pvz.: žmogaus vardo, miesto ilgumos ir platumos koordinačių ir t.t.

Kas keisčiausia, tai kad viena ryšio pusė yra (mums slapčiom) saugoma
prie kitų egzempliorio duomenų (tipo esybės „A“ egzempliorius saugo esybės „B“ egzempliorio PK)...
O kita pusė, GALI būti: 1. surasta programatiškai (kai reikia) arba 2. irgi saugoma.

#image("example4.png")

*Identifikuojantys ryšiai* leidžia naudoti kitų esybių egzempliorius, kad gautume norimą egzempliorių. 

Esybės, kurios turi identifikuojančius ryšius, gali neturėti pirminio rakto. \
Pavyzdžiui: jei turime 
+ esybę _DYDIS_ su atributais: _Ilgis_, _Plotis_ ir _Aukštis_,
+ esybes _VAIZDO_PLOKŠTĖ_ ir _VENTILIATORIUS_,
+ identifikuojančius ryšius tarp:  _VAIZDO_PLOKŠTĖ_ --- _DYDIS_ ir _VENTILIATORIUS_ --- _DYDIS_
Turėdami vaizdo plokštę arba ventiliatorių galime sužinoti jų dydžius. \
Turėdami atskirą dydį galime jį išmesti į šiukšlių dėžę...

#pagebreak()

= Žymėjimas

Mes *žymime* tą pačią diagramą dviem skirtingais būdais...

Iš pradžių maniau, kad Microsoft vėl pasišiukšlino, 
tačiau #link("https://docs.oracle.com/cd/F49540_01/DOC/java.815/a64686/05_dev1.htm#18622")[čia] yra tas pats žymėjimas kaip Visio, iš Oracle(ERD kūrėjų) 1999 metais.
Be to, aš naudojau Microsoft Visio 2010 metų ir dar net tada ten nebuvo „Crow's foot“ diagramos,
tai...

*Žemiau yra dėstytojos žymėjimas*, kurį, jei neklystu, naudosim per kontrolinį darbą: 

#image("example5.png")

*Esybių ryšių „skaitymas“* -- ryšio perteikimas tekstu, pagal formulę:

#image("example6.png")

„(veiksmažodis)“ gali būti ir ne vienas žodis, ir, pavyzdžiui, dalinai nueiti už “ESYBĖ_2“.

#pagebreak()

= n:m ryšys

*Daug-su-daug ryšio sprendimo* metu reikia sukurti naują esybę su, dažniausia, dviem identifikuojančiais ryšiais.

Nauja esybė GALI turėti savo atributų, pavyzdžiui: naują kiekį ir t.t.

#image("example9.png")

_Dėstytojos pavyzdžiuose identifikuojančių brukšniukų nėra. Manau, kad kažkas tiesiog užmiršo..._

#pagebreak()

= Subesybės

*Subesybės* yra vienos kitoms prieštaringos\* esybės sukištos į „superesybę“, kurios paveldi šios „superesybės“ atributus. \
\*„vienos kitoms prieštaringos“ = „dvi negali egzistuoti tuo pačiu metu“ = „arba viena, arba kita“.

Subesybės dažnai atsiranda, kai mes turime kelias iš anksto žinomas kažkokios esybės kategorijas. \ 
Pavyzdžiui:

#image("example7.png")

Programavime, subesybių atitikmuo yra „union“ arba sumos tipai... \
O čia dar gali būti ir tie lankai ant ryšių (kurių, greičiausia, nereiks)

#pagebreak()

= Normalizavimas

*Normalizavimas* yra rinkinys taisyklių, kuris padeda nesuklysti
planuojant duomenų bazes. Normalizavimas, šiaip, ir reiškia: 
„supaprastinti kažką į normalesnę/standartiškesnę formą (pagal tam tikras taisykles).“

Iš atributų kurie neatitinka tikrinamosios norminės reikia padaryti naujas esybės arba pan.,
kol galiausia viskas visur atitiks tą norminę formą.

Pirmos trys norminės formos:

*1NF:* „Visi atributai yra vienareikšmei.“ \ 
Tipo, atributuose negalima saugoti sąrašų, nes, durnai atrodo, kai lentelės langely kablelių prikaišyta...

*2NF:* „Visi esybės atrbutai yra priklausomi nuo viso esybės unikalaus identifikatoriaus.“ \
Jeigu esybė turi tik vieną raktą, tai ji iš karto atitinka 2NF. \
Kitaip, reikia tikrinti kiekvieną ne raktinį atributą ir žiūrėti: \
ar tikrai, kad jį gautume mums REIKIA visų raktų ir identifikuojančių ryšių?

*3NF:* „Esybė neturi atributo nepriklausančio UID, kuris priklausytų nuo kito atributo nepriklausančio UID.“ \
Netinka tada, kai paprasti atributai gali priklausyti nuo kitų neidentifikuojančių/ne kandidatų į pirminius raktus.

#image("example8.png")
_Ar taip ar taip, nežinot dviejų knygų, juo labiau, su tuo pačiu pavadinimu... Nesistenkit._

// TODO
// normalizavimas
// n:m ryšiai

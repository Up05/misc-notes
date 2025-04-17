#set page(margin: ( top: 1cm, bottom: 1cm, right: 1cm, left: 1cm ))

#show link: it => { text(rgb("0000FF"), {it}) }
#show heading.where(level: 1): it => [
    #set align(center)
    #set text(14pt, weight: "bold")
    #set block(spacing: 14pt)
    #block(upper(it))  
]

// #align(center)[ #text(size: 24pt, weight: "bold")[ Tinklai ] ]

= OSI modelis
#v(-0.5em)
#align(center)[Open Systems Communication]

OSI modelis -- paskirstymas lygių kuriais TCP duomenų paketas nulipa viename kompiuteryje ir vėl užlipa kitame.

#table(
    columns: 2,
    stroke: none,
    [ Lygiai ], [ Paaiškinimas ],
    [ 7. Taikomasis ],   [ Vartotojui, čia yra HTTP, SMTP (Simple Main Transfer Protocol) ir FTP (File ...) ],
    [ 6. Atvaizdavimo ], [ Duomenų formatavimas, suspaudimas ir užšifravimas ],
    [ 5. Sesijos ],      [ #link("https://developer.mozilla.org/en-US/docs/Glossary/TCP_handshake")[Paspaudžia ranką], prie paketo prideda išsiuntimo laiką ir t.t. ],
    [ 4. Transporto ],   [ TCP ir UDP, prižiūri, kad paketai būtų nusiųsti, patikrina juos dėl klaidų ir surušiuoja pagal laiką ],
    [ 3. Tinklo ],       [ Išsiaiškina greičiausią kelią paketams pasiekti gavėją, sutvarko adresavimą, čia: IP, ICMP ir RIP ],
    [ 2. Ryšio ],        [ Veikia su MAC adresais ],
    [ 1. Fizinis ],      [ Pavyzdžiui, kabelis arba Wi-Fi ],
)



= ARP
#v(-0.5em)
#align(center)[Address Resolution Protocol]

ARP yra būdas susieti IP adresą su vieno įrenginio MAC(Media Access Control) adresu. Dažnai IP adresas jau yra ir jį reikia susieti su MAC. 

`FF:FF:FF:FF:FF:FF` yra transliacinis adresas, jį visad gauna visi tinklo kompiuteriai. Tai reikalinga norint paklausti kuriam kompiuteriui priklauso IP adresas. Išsiunčiamas paketas: `{ FF:FF:FF:FF:FF:FF, Gavėjo IP, Savo MAC, ... }`

```lua
arp -a             -- parodo IP ↔ ARP lentelę
arp -s IP MAC      -- prideda įrašą
arp -d IP          -- ištrina įrašus 
```

= Protokolai

#table(
    columns: 3,
    stroke: none,
    [ HTTP ], [ HyperText Transfer Protocol ], [ Dažniausia naudojamas interneto naršklėse, v1.1 pastatyta ant TCP ],
    [ TCP ], [ Transmission Control Protocol ], [ Užtikrina kad visi paketai pasieks gavėją išsiuntimo tvarka ],
    [ UDP ], [ User Datagram Protocol ], [ Greitai, kaip papuola, permeta paketus kažkur į gavėjo pusę ],
    [ IP  ], [ Internet Protocol ], [ IPv4 Laiko adresus, max 64KiB duomenų ir dar papildomos informacijos ], 
    [ ARP ], [ Address Resolution Protocol ], [ Laiko aukštesnio lygio protokolo tipą (pvz.: 8 atitinka HTTP) ir adresus ],
    [ RIP ], [ Routing Information Protocol ], [ Nusiunčia kitiems routeriams savo `se` ir `fa` portų adresus. ],
)

= IPv4 adresavimas

IPv4 adresas: `255.255.255.255`

Sudarytas iš 4 bitų arba 32 baitų, turi (priklausomai nuo kaukės) tinklo ir PC adresą.

Kaukė pasako kuri adreso dalis yra tinklo. Kaukėje vienetukai negali turėti „skylių“, nuo kairės visi: `1`, po jų: `0`. 

Adresų klasės:
```
Klasė A (adresams: 1-127) (daugiausia hostų/mazg)
Kaukė: 255.0.0.0 (11111111.00000000.00000000.00000000) /8
Privatūs: 10.0.0.0 - 10.255.255.255

Klasė B (adresams: 128-191)
Kaukė: 255.255.0.0 (11111111.11111111.00000000.00000000) /16
Privatūs: 172.16.0.0 - 172.31.255.255

Klasė C (adresams: 192-223) (tik 254 PC)
Kaukė 255.255.255.0 .. /24
Privatūs: 192.168.0.0 - 192.168.255.255
```

Default gateway -- routerio porto, prie kurio hostas yra prijungtas, adresas. 

= VLSM
#v(-0.5em)
#align(center)[Variable Length Segmented Mask]

Čia būna VLSM skaičiuotuvai, kurie pagal IP klasę ir reikalingų hostų kiekį gali paskaičiuoti mažiausias būtinas kaukes.

Čia pagrinde reikia prisiminti, kad kiekvienas vienetukas kaukėja padalina hostų skaičių iš dviejų ir padaugina tinklų skaičių iš dviejų. Tai jei yra 3 routeriai, reikės minimum 3 tinklų (čia, dažnai, potinklių). ir tada, skaičiuotuvas padės su hostais.

= VLAN
#v(-0.5em)
#align(center)[tinklo atskirimas per switch'ą]

Atskiria tinklą su komutatoriais, per VLAN lentelę:

```lua
Switch1#vlan database
Switch1(vlan)#vlan 10 name VLAN10 -- 10 yra ID, VLAN10 yra tiesiog pavadinimas mums
Switch1(vlan)#vlan 20 name VLAN20

Switch1(config)#interface f0/1                -- VLAN'ai būna skirtinguose interface'uose
Switch1(config-if)#switchport mode access   
Switch1(config-if)#switchport access vlan 10  -- interface'as fa 0/1 praleidžia tik id 10 paketus
Switch1(config-if)#exit
Switch1(config)#interface f0/2
Switch1(config-if)#switchport mode access
Switch1(config-if)#switchport access vlan 20  -- interface'as fa 0/2 praleidžia tik id 20 paketus

Switch1(config)#interface f0/12             -- fa 0/12 būtų prijungtas prie routerio/išorės beje
Switch1(config-if)#switchport mode trunk    -- kažką padaro su paketai, nežinau ką čia nukerta
```

= VLAN SUB
#v(-0.5em)
#align(center)[routerio sub portai]

Galima iš vieno `fa` porto gauti praktiškai betkiek, taip kuriant daugiau potinklių ir gateway'ėjų.
```lua
R1(config)#interface fastethernet 0/0.100  -- 0.0: fizinis portas, .100: išgalvotas sub-portas
R1(config-subif)#encapsulation dot1Q 100   -- prie paketų prisegs „dot1Q“ info ir sub porto ID=100
R1(config-subif)#ip address 172.16.100.1 255.255.255.0 -- čia jau nebūtinai `100` tiesiog gateway IP
```

= Static routing
#v(-0.5em)
#align(center)[Kaip šnekasi du maršrutizatoriai]

Routeriai/maršrutizatoriai turi skiltelę: „static routing“, kurioje yra:
#table(columns: 2)[Network][Tinklų filtras arba pan. Tiesiog palikite: `0.0.0.0`][Mask][Network adreso kaukė, irgi tiesiog palikit: `0.0.0.0`][Next hop][routerių adresai. Routeriai yra susieti „serial“ jungtimi ir portais, tai čia tiesiog tas.]

#align(center)[#image(width: 50%, "static-routing.png")]


#pagebreak()


= RIP
#v(-0.5em)
#align(center)[routeriai pasakoja apie save visiems]

#align(center)[== v1]

Neveikia su potinkliais.

cisco packet tracer'yje yra defaultas ir vienintelė versija pasiekiama su mygtukais.
Tiesiog pridėkit routerio laikomus IP adresus ir tiek.

#align(center)[== v2]

CLI:
Visuose routeriuose 
```lua
R1(config)#router rip
R1(config-router)#version 2
R1(config-router)#network IP         -- Čia eina portuose esantys adresai
R1(config-router)#network 172.16.3.1 -- Jei 'fa' porte yra 172.16.3.1 tai čia irgi tas pats
```

Viename iš routerių:
```lua
R3(config)#ip route 0.0.0.0 0.0.0.0 HOST_PC_IP  -- static routing (beje)
R3(config)#router rip
R3(config-router)#default-information originate
```
_Reikalingams nepažįstamiems tinklams, taip vadinamas: „Gateway of Last Resort“_

= Tinklo sujunginėjimas (mano supratimu)

Pirmiausia, dėliojant „topologiją“(daiktus ir sujungimus) reikia atidžiai žiūrėti į portus (pvz.: fa0/0, se0/0/1, ...) ir įrenginių pavadinimus(Router1, Router2, ...), nereikia tiesiog pradėt nuo bet kurio galo.

Portai: fa(fast ethernet) -- hostams ir komutatoriams (switch), se(serial) -- tik routeris su routeriu. kad pridėtumėt `se` jungtis reikia išjungti routerį ir, per „Physical“, į routerį įdėti `WIC-1T` arba `WIC-2T`.

#table(columns: 2)[hostų adresai][][Default gateway][Routerio porto (arba sub-interfaso) adresas, jei nėra potinklio (kaukėje yra 255 arba 0), tai paskutinis adreso skaičiukas tiesiog bus `1`][fa IP][Tiesiog, hosto adresas, dažnai toks pat kaip default gateway, bet paskutinis skaičiukas yra ne `1`, o `2`, `3` ir t.t.]

#table(columns: 2)[routerių adresai][][fa IP][Yra hostams ir komutatoriams, dažnai default gateway.][se IP][yra IP adresas per kurį routerį pasiekia kiti routeriai. turi būti kitame tinkle/potinklyje nei visi kiti routeriai.][static routing][pasako kitą routerį, į kurį siūsti paketą. tinklas: `0.0.0.0`, kaukė: `0.0.0.0`, next hop: kito routerio prijungto se porto adresas][RIP][v1 nesupranta potinklių, gali būti konfiguruojamas per GUI, v2 per komandų eilutę, vienam routeryje reikia įvesti kelias komandas, kituose tik to routerio portų adresus]

Komutatoriuose, yra daromi VLAN, be to, reikia porte kuris sujungtas su routeriu, nustatyti `Trunk` `1-1005`, o su hostais: `Access` `1` (vietoj 1 (default'o) galima nustatyti VLAN id).





(:Zadanie 26:)
(: for $k in doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\swiat.xml')/SWIAT/KONTYNENTY/KONTYNENT
   return <KRAJ> { $k/NAZWA, $k/STOLICA } </KRAJ> :)


(:Zadanie 27:)
(: for $k in doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\swiat.xml')/SWIAT/KRAJE/KRAJ
return <KRAJ>
  { $k/NAZWA, $k/STOLICA }
</KRAJ> :)


(: Zadanie 28:)
(: for $k in doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\swiat.xml')/SWIAT/KRAJE/KRAJ[starts-with(string(NAZWA),'A')]
   return <KRAJ>{ $k/NAZWA, $k/STOLICA }</KRAJ> :)


(: Zadanie 29 :)
(: for $k in doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\swiat.xml')/SWIAT/KRAJE/KRAJ[substring(string(NAZWA),1,1) = substring(string(STOLICA),1,1)]
   return <KRAJ>{ $k/NAZWA, $k/STOLICA }</KRAJ> :)


(:Zadanie 33::)
(:doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\zesp_prac.xml')/ZESPOLY/ROW[NAZWA='SYSTEMY EKSPERCKIE']/PRACOWNICY/ROW/NAZWISKO:)


(:Zadanie 34::)
(:count(doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\zesp_prac.xml'):)
(:  /ZESPOLY/ROW[ID_ZESP=10]/PRACOWNICY/ROW ):)


(:Zadanie 35:)
(:doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\zesp_prac.xml')//PRACOWNICY/ROW[ID_SZEFA=100]/NAZWISKO:)


(:Zadanie 36:)
sum(doc('C:\Users\krybr\Desktop\ztpd_1\ztpd_1\lab XPATH-XSLT\zesp_prac.xml')
  //PRACOWNICY/ROW[ID_ZESP = //PRACOWNICY/ROW[NAZWISKO='BRZEZINSKI']/ID_ZESP]/PLACA_POD
)


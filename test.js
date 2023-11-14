
async function get(sId, form){
const res = await fetch("https://buchung.hochschulsport-hamburg.de/cgi/anmeldung.fcgi", {
  "headers": {
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "accept-language": "en-GB,en-US;q=0.9,en;q=0.8,de;q=0.7",
    "cache-control": "max-age=0",
    "content-type": "application/x-www-form-urlencoded",
    "sec-ch-ua": "\"Google Chrome\";v=\"119\", \"Chromium\";v=\"119\", \"Not?A_Brand\";v=\"24\"",
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "\"macOS\"",
    "sec-fetch-dest": "document",
    "sec-fetch-mode": "navigate",
    "sec-fetch-site": "same-origin",
    "sec-fetch-user": "?1",
    "upgrade-insecure-requests": "1",
    "Referer": "https://buchung.hochschulsport-hamburg.de/cgi/anmeldung.fcgi",
    "Referrer-Policy": "strict-origin-when-cross-origin",
    //"Accept-Encoding": "gzip"
  },
  "body": `fid=${sId}&Phase=final&Termin=2023-11-16&tnbed=+1&sex=X&vorname=Robin&name=Naumann&strasse=Eichenweg+6&ort=79183+Waldkirch&statusorig=S-UNIH&matnr=7785279&email=robin.naumann%40studium.uni-hamburg.de&telefon=%2B491603204438&preis_anz=0%2C00+EUR&_formdata=${form}&pw_newpw_${sId}=`,
  "method": "POST"
});
console.log(res);
console.log(await res.text());
}

get(
"45a2f1db78947966483021896c972ffb4d4f5b7a159e7dd49e25ff6e",
"3399957774"
);


//work:fid=db26b11fdcae615dffe6837471c225514aa2954144d8d4f001e70348&Phase=final&Termin=2023-11-16&tnbed=1+&sex=X&vorname=Robin&name=Naumann&strasse=Eichenweg+6&ort=79183+Waldkirch&statusorig=S-UNIH&matnr=7785279&email=robin.naumann%40studium.uni-hamburg.de&telefon=%2B491603204438&preis_anz=0%2C00+EUR&_formdata=3399949712&pw_newpw_db26b11fdcae615dffe6837471c225514aa2954144d8d4f001e70348=
//user:fid=20c9b6bd8ea1807b2a642885abe3af7aadc7a3e198721edef89255bf&Phase=final&Termin=2023-11-16&tnbed=+1&sex=X&vorname=Robin&name=Naumann&strasse=Eichenweg+6&ort=79183+Waldkirch&statusorig=S-UNIH&matnr=7785279&email=robin.naumann%40studium.uni-hamburg.de&telefon=%2B491603204438&preis_anz=0%2C00+EUR&_formdata=3399950484&pw_newpw_20c9b6bd8ea1807b2a642885abe3af7aadc7a3e198721edef89255bf=

//user:fid=7227cc968126b5d2d6c585b4df30b8ad63326fc8d16c04e720f4df2f&Termin=2023-11-16&pw_pwd_7227cc968126b5d2d6c585b4df30b8ad63326fc8d16c04e720f4df2f=&pw_emai1=&sex=X&vorname=Robin&name=Naumann&strasse=Eichenweg+6&ort=79183+Waldkirch&statusorig=S-UNIH&matnr=7785279&email=robin.naumann%40studium.uni-hamburg.de&telefon=%2B491603204438&newsletter=&tnbed=1
//work:fid=db26b11fdcae615dffe6837471c225514aa2954144d8d4f001e70348&Termin=2023-11-16&pw_email=&pw_pwd_db26b11fdcae615dffe6837471c225514aa2954144d8d4f001e70348=&sex=X&vorname=Robin&name=Naumann&strasse=Eichenweg+6&ort=79183+Waldkirch&statusorig=S-UNIH&matnr=7785279&email=robin.naumann%40studium.uni-hamburg.de&telefon=%2B491603204438&newsletter=&tnbed=1


//fid=9625271704c406720e408c2ddaa20acbb598befb18d092c3a9f99050
//Phase=final
//Termin=2023-11-15
//tnbed=1+&sex=X
//vorname=Robin
//name=Naumann
//strasse=Eichenweg+6
//ort=79183+Waldkirch
//statusorig=S-UNIH
//matnr=7785279
//email=robin.naumann%40studium.uni-hamburg.de
//telefon=%2B491603204438
//preis_anz=0%2C00+EUR
//_formdata=3399773468
//pw_newpw_9625271704c406720e408c2ddaa20acbb598befb18d092c3a9f99050=


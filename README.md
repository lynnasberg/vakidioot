# vakidioot
Alles wat je nodig hebt om een Vakidioot te maken

1. 1. Voor Windows-gebruikers: installeer *MiKTeX* van https://miktex.org/download (zet 'install missing packages on the fly' aan)
   2. Voor Mac-gebruikers: installeer *MacTex 2016* (of hoger) van https://tug.org/mactex/
   3. Voor Linux-gebruikers: installeer *TeX Live* (texlive-base of texlive-full)
2. Download deze repository (Code -> Download ZIP)
3. Ga naar de map */Fonts* en installeer alle fonts in deze map. Op Windows doe je dit door ctrl+a te doen, dan rechts te klikken en op "Install" te drukken.
4. (Windows only) Open de MiKTeX Console en ga naar Tasks -> Refresh file name database en daarna Tasks -> Refresh font map files.
5. Open nu je tex-editor naar keuze (ik raad TeXstudio aan https://www.texstudio.org/). Zorg dat de compiler op 'XeLaTeX' staat (in TeXstudio via Options -> Configure TeXstudio -> Build, verander 'Default Compiler').
6. Zet de bestanden in */Vakidioot-stijl* allemaal in de map (elke map!) waarin je gaat werken aan .tex bestanden voor de Vakidioot.

Nu zou het hopelijk moeten werken! Als je nu een .tex bestand voor een vakidioot artikel compileert, gaat je computer eerst allemaal packages installeren. Daarna is ie klaar voor gebruik! Lukt het niet? Stuur dan Lynn Asberg een berichtje.  Ik durf geen garantie te geven voor Mac en Linux! Als je aanvullingen of verbeteringen hebt, stuur ze dan ook vooral door!

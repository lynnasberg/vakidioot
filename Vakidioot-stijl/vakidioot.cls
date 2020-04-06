%
%
% oooooo     oooo       ooo       o8o      .o8  o8o                    .   
%  `888.     .8'        `88       `"'       88  `"'                  .o8   
%   `888.   .8' .ooo.    88   ooo ooo   .ooo88 oooo   .ooo.   .ooo. .o88oo 
%    `888. .8' `P  )8b   88 .8P'  `88  d8' `88  `88  d8' `8b d8' `8b  88   
%     `888.8'   .oP"88   88888.    88  88   88   88  88   88 88   88  88   
%      `888'   d8(  88   88  `b.   88  88   88   88  88   88 88   88  88  . 
%       `8'    `Y88""8o o88o o88o o88o `Y8b8P'o o88o `Y8b8P' `Y8b8P'  "888" 
%
%
%
%                         "Its not a bugg, thats how they programmed it"
%                                            - Anonieme forumgebruiker, 2006
%
%
%
% Je bekijkt nu de nieuwe nieuwe nieuwe nieuwe Vakidioot-class! Omdat het erg
% vermoeiend is omdat het steeds maar over de nieuwe nieuwe nieuwe nieuwe
% Vakidioot-class te hebben, noemen we dit in het vervolg maar weer gewoon "de
% Vakidioot-class".
%
% Het uitgangspunt bij het bouwen van deze versie van de Vakidioot-class was (en
% is) om een zo simpel mogelijke class te hebben die betrekkelijk eenvoudig door
% niet-TeX-wizards aan te passen, uit te breiden, en te bugfixen moet zijn.
%
% Dit is gedaan door - waar mogelijk - zoveel mogelijk definities voor algemene
% verenigingsbladeigenschappen en -bouwblokken weg te stoppen in een aparte
% bonaparticle-class waar deze Vakidioot-class een "specifiek geval" van is.
%
% Wat kun je in déze class-file dus allemaal vinden? Nou:
%  - Standaardtekstjes en placeholders voor commando's die voor ieder artikel
%    of nummer (minstens) één keer uitgevoerd moeten worden, zoals \title{} en
%    \magazinetheme{};
%  - De kleuren die horen bij de A-Eskwadraat, en bij de verschillende thema's/
%    genres/categorieën/soorten artikelen;
%  - Lettertypes. In de vernieuwde versie van deze extra-grote nieuwe nieuwe
%    nieuwe nieuwe class zijn dat TeX Gyre Pagella voor de broodtekst en
%    Bitstream Vera Sans voor math mode;
%  - De standaardpaden waar de LaTeX-compiler naar plaatjes e.d. zoekt;
%  - Vakidioot-commando's. Dit zijn vooral façades voor bonaparticle-commando's,
%    maar hier en daar zitten er ook grotere commando's tussen, zoals die voor
%    het maken van het colofon.
%
% Mocht je deze class willen uitbreiden, dan kun je het beste je nieuwe code
% toevoegen aan één van de bestaande secties (waarschijnlijk de sectie met
% commando's) of een nieuwe sectie toevoegen.
% Als je een bugje tegenkomt in de bonaparticle-class, dan kun je het beste de
% nieuwste versie daarvan van GitHub halen (*). Zit de bug daar nog steeds in,
% dan kun je die het beste daar melden (of zelf (laten) fixen en vervolgens je
% bugfix daar naartoe uploaden).
%
% (*) github.com/chunfeilung
%
%
% Met dank aan:
% > Babette de Wolff (2)
% > Aldo Witte (1)
% > Harm Backx (1)




% ---------------------------------------------------------------------------- %




\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{vakidioot}[
    2017/09/21
    De kleurrijke extra-grote nieuwe nieuwe nieuwe nieuwe Vakidioot-class. 
]




%    R E C E N T E   W I J Z I G I N G E N
%    -------------------------------------
% 2020/04/06 | Naam van logo veranderd naar het-volledige-vakidioot-logo-2019.pdf
% 2019/09/16 | floatinginfobox en floatinginfoboxtransparent toegevoegd
% 2017/09/21 | Genrekleuren bijwerken: onderwijs wordt geel, overig roze en geschiedenis rood
% 2017/05/14 | Aanpassingen om beter overweg te kunnen met het nieuwe formaat van BladNL
% 2016/03/08 | Maak gebruik van XeTeX's taal- en fontafhandeling
% 2015/11/25 | Regelafstand van \chapter bepalen a.d.h.v. font-size van \chapter
% 2015/10/23 | Variabele gebruiken i.p.v. "Vakidioot" bij reset paginavariabelen
% 2015/09/30 | Logo i.p.v. "Vakidioot" tonen onderaan iedere pagina
% 2015/09/20 | \fotostrip ook \theauthor laten resetten
% 2015/??/?? | @DUTCH en @ENGLISH toevoegen als alias voor @dutch en @english




% ---------------------------------------------------------------------------- %




%    C L A S S - O P T I E S
%    -----------------------
% In deze sectie worden de class-opties genoemd die meegegeven kunnen worden bij
% het gebruiken van de vakidioot-class. Bij iedere optie staat een korte uitleg
% over wat het doet.




% Zorg ervoor dat er onder meer snijranden en een kek kleurenbalkje om de pagina
% heen verschijnen. Let op dat dit commando nog niets doet met eventuele
% conversies van afbeeldingen in RGB- naar CMYK-formaat, of het comprimeren van
% afbeeldingen voor de niet-printversie.
%
%  +- Voorbeeld ------------------------+
%  |                                    |
%  |  \documentclass[print]{vakidioot}  |
%  |                                    |
%  +------------------------------------+
\DeclareOption{print}{
  \PassOptionsToClass{\CurrentOption}{bonaparticle}
}


% Dit behoeft neem ik aan geen verdere uitleg.
\ProcessOptions\relax




% ---------------------------------------------------------------------------- %




% Sorry mensen, maar zonder XeTeX heb je hier niet heel veel aan.
% LuaTeX zou ook moeten werken maar heeft niet heel hoge prioriteit.
\RequirePackage{iftex}
\ifPDFTeX
	\PackageError{Vakidioot}{XeTeX (of LuaTeX) is nodig om deze klasse te
	gebruiken. Typ H<enter> voor meer info.}
	{Als je een of ander grafische TeX-verwerker gebruikt, probeer dan bij je
	instellingen de compiler pdfLaTeX te vervangen met XeLaTeX.  Soms zit deze
	optie naast de aantrekkelijke groene knop om PDF's te genereren.  In dat
	geval is het handig om ook nog in je instellingen te kijken of daar iets in
	de trant van "default compiler" staat, en die ook op XeLaTeX te zetten.
	Onder andere lettertypes en Unicodekarakters vereisen ondersteuning door
	een modernere compiler dan pdfLaTeX. Tenzij je weet waarom je pdfLaTeX moet
	gebruiken, zou je geen problemen moeten hebben als je andere .tex-bestanden
	compileert met XeLaTeX.}
\fi




% ---------------------------------------------------------------------------- %




% De vakidioot-class is een subclass van bonaparticle. Zo'n beetje alle speciale
% commando's die je gebruikt bij het opmaken van Vakidiootartikelen zijn onder
% water dan ook bonaparticle-commando's. Hier laden we die in. De laatste versie
% is altijd te downloaden vanaf de GitHub-repo van chunfeilung.
\LoadClass[bladnlsize]{bonaparticle}




% ---------------------------------------------------------------------------- %




%    C O N S T A N T E N
%    -------------------
% In deze sectie tref je constanten (dingetjes die een bepaalde waarde
% bevatten) aan. Technisch gezien zijn het gewoon variabelen, en weerhoudt niets
% je ervan om ze een andere waarde te geven, maar ik raad sterk af om hier iets
% in te veranderen - en als je het al doet, doe het dan direct hieronder.




%    T e k s t   e n   l e t t e r t y p e s
%    - - - - - - - - - - - - - - - - - - - -
% Hier stellen we in dat we graag Linotype Frutiger willen als lettertype
% voor tekst op groot formaat, zoals koppen en secties, en TeX Gyre Pagella
% voor de broodtekst.

% XeTeX fonthandling
\RequirePackage{fontspec}
\setmainfont{TeX Gyre Pagella}
% Op verscheidene plekken zul je nu \fontsize{n}{k} \bigfont zien,
% dat is om de kopjes enzo sans-serif te maken.
% Willen we dit ook in bonaparticle implementeren?
\newfontfamily{\bigfont}{frutiger.ttf}[
	BoldFont = frutbd.ttf,
	ItalicFont = frutit.ttf,
	BoldItalicFont = frutz.ttf,
	Scale=MatchLowercase
]
% Kan geen fijn wiskundefont vinden, dus standaard sans-serif is goed genoeg
%\RequirePackage{sfmath}
\setmonofont{VeraMono.ttf}[Scale=MatchLowercase]

% Babelequivalent voor XeTeX, voor woordafbreking en vriendjes
\RequirePackage{polyglossia}
\setdefaultlanguage{dutch}
\setotherlanguages{english}
\changefontsizes[10pt]{9pt}



%    T e k s t e n   e n   p l a c e h o l d e r s
%    - - - - - - - - - - - - - - - - - - - - - - -
% Deze lijst bevat teksten die nooit aangepast moeten worden (bijv. \aesnaam) en
% commando's waarmee placeholders worden gezet voor een aantal blad- en artikel-
% brede variabelen.


% Kopje boven de inhoudsopgave
\renewcommand{\thetableofcontentstitle}{In dit nummer}


% \aesnaam -> A--Eskwadraat
\newcommand{\aesnaam}{\mbox{A–Es}kwadraat\xspace}


% \vakidioot -> Vakidioot
\newcommand{\vakidioot}{Vak\mbox{idioot}\xspace}


% \theuitgave -> Datum van uitgave. Vergelijkbaar met \themagazineissue, maar
%                dan preciezer.
\newcommand{\theuitgave }{\hl{VUL DATUM IN}}


% \theoplage -> Het aantal exemplaren waarvoor een opdracht is afgegeven voor
%               deze batch.
\newcommand{\theoplage  }{\hl{VUL OPLAGE IN}}


% \thedeadline -> De datum waarop inzendingen van lezers uiterlijk binnen moeten
%                 zijn.
\newcommand{\thedeadline}{\hl{VUL DEADLINE IN}}


% \themagazinename -> Vakidioot. De enige goede reden om dit aan te passen is
%                     als het blad van naam verandert.
\magazinename{\vakidioot}


% \themagazinetheme -> Proef, Perspectief, Theepot, enz. Losse artikelen mogen
%                      in de regel geen thema definiëren (dit wordt door de
%                      class niet afgedwongen!), dus bij het TeXen daarvan zul
%                      je in principe de tekst hieronder zien. Dient door de
%                      hoofdredacteur ingevuld te worden in het hoofdbestand.
\magazinetheme{Thema}


% \themagazineissue -> De maand en het jaar waarop deze Vakidioot waarschijnlijk
%                      ongeveer gaat uitkomen. Dient door de eindredacteur
%                      ingevuld te worden in het hoofdbestand.
\magazineissue{<maand> <jaar>}


% Deze variabelen willen we voor ieder artikel gereset hebben.
\renewcommand{\resetbonaparticlevariables}{
    \setcounter{figure}{0}
    \setcounter{equation}{0}
    \setcounter{table}{0}

    % \thegenre -> Vakidioot. Artikel-specifiek commando. Mocht er geen thema
    %              zijn, dan is dit gewoon een goeie default.
    \genre{\vakidioot}

    % \thetitle -> Een standaard titel waarvan het iets minder erg is als die
    %              toch er doorheen glipt.
    \title{Een titel om nooit te vergeten}

    \subtitle       {\vspace{-0.5\baselineskip}} % Prevent awkward whitespace
    % \theauthor-> (leeg). Het komt nog geregeld voor dat een artikel geen
    %              auteur heeft. Dergelijke artikelen zijn vaak geschreven door
    %              "de redactie". Daarom kan de default hiervoor het beste leeg
    %              zijn.
    \author{}

    % \thegenrecolor -> black. Als default kan het beste een kleur worden
    %                   gekozen die niet al voor specifieke types artikelen
    %                   wordt gebruikt.
    \genrecolour{black}

    \renewcommand{\theheadercolor}{gray}
    \renewcommand{\thefootercolor}{black}

    % De meeste artikelen zullen in het Nederlands geschreven zijn. Als het een
    % keertje niet zo is, dan moeten mensen zelf maar de taal aanpassen.
    \selectlanguage{dutch}
}


% Zorg ervoor dat alles op zijn minst een keertje gereset is
\resetbonaparticlevariables




%    K l e u r e n
%    - - - - - - -
% De standaard voorgedefinieerde kleuren (bovenop de kleuren die je al standaard
% bij het inladen van xcolor krijgt).

% Ouderwetse kleuren, gebruik deze AUB niet meer.
\definecolor{aesgeel}    {HTML}{FAB42C} % is verouderd want overlapt met uugeel, dus we gebruiken nu aesrood
\definecolor{overiggrijs}{HTML}{999999} % is verouderd want saai, dus we gebruiken nu overigroze

% Omdat voor de printversie kleuren in een net wat ander formaat gedefinieerd
% moeten zijn, wordt iedere kleur tweemaal gedefinieerd.
\ifprint
    \definecolor{incarood}{cmyk}{0, 100, .64, .15}
    \definecolor{aesrood}    {cmyk}{0    ,    1,    .8,    .41}
    \definecolor{inkuoranje} {cmyk}{0    , .6588,    .8,     .1}
    \definecolor{uugeel}{cmyk}{0, .31, 1, .13}
    \definecolor{wiskgroen}  {cmyk}{.6745,     0, .9961, .3216}
    \definecolor{vakblauw}{cmyk}{1, 0, .33, .4}
    \definecolor{natkblauw}  {cmyk}{.8196, .4392,     0,     0}
    \definecolor{idiootpaars}{cmyk}{.8   ,     1,     0,     0}
    \definecolor{overigroze}{cmyk}{0, .8, .11, .2}
\else
	\definecolor{incarood}{HTML}{BB0044}
	\definecolor{aesrood}    {HTML}{97001E}
	\definecolor{inkuoranje} {HTML}{F36210}
	\definecolor{uugeel}    {HTML}{DD9900}
	\definecolor{wiskgroen}  {HTML}{3B8825}
	\definecolor{vakblauw}{HTML}{009966}
	\definecolor{natkblauw}  {HTML}{3D7BC7}
	\definecolor{idiootpaars}{HTML}{542791}
	\definecolor{overigroze}{HTML}{A1228F}
\fi

% Sta o.a. de [H]-optie toe op floats, zodat ze mooi in multicols passen.
% Stiekem zorgt [H] ervoor dat ze helemaal niet meer zweven!
\usepackage{float}

%    O v e r i g e   z o o i
%    - - - - - - - - - - - -


% Dit stopt de volgende twee foutmeldingen:
% - 'Package babel Error: You haven't defined the language DUTCH yet.'
% - 'Package babel Error: You haven't defined the language ENGLISH yet.'
%
% (Ja, dit is symptoombestrijding, maar ik heb wel betere dingen te doen)
\makeatletter
\let\l@DUTCH\l@dutch
\let\l@ENGLISH\l@english
\makeatother




% ---------------------------------------------------------------------------- %




%    O P M A A K
%    -----------
% Vakidioot-specifieke opmaak wordt gedefinieerd als delta's ten opzichte van
% de standaard bonaparticle-stijl.

% Tweak verscheidene afstanden.
% Dit zou qua inhoud ook in de bonaparticle-class kunnen,
% zodat in de vakidioot-class alleen maar specifieke vakidiootdingen komen.

% Wat meer ruimte tussen multicols voor mooiere leesbaarheid
\setlength{\columnsep}{25pt}
\setlength{\columnseprule}{0.3pt}
% Geef een leuk kleurtje aan de balk tussen de multicols
\def\columnseprulecolor{\color{\thegenrecolor}}

% Wat meer ruimte tussen broodtekst en voetnoten
\setlength{\footnotesep}{0.5\baselineskip}
\addtolength{\skip\footins}{8pt}
% Maar juist minder ruimte tussen de onderkant van floats en de rest van de tekst
% TODO: dit is niet heel netjes, maar ik weet anders niet waar de ruimte vandaan komt
\setlength{\intextsep}{\baselineskip}
\setlength{\belowcaptionskip}{-\baselineskip}

% Utility commands:
% Delete all horizontal distance of the given text, making it overlap with previous text
\newcommand{\hsmash}[1]{\makebox[-\width]{#1}\makebox[\width]{\phantom{#1}}}
% Delete all horizontal distance of the given text, making it overlap with following text
\newcommand{\antihsmash}[1]{\makebox[\width]{\phantom{#1}}\makebox[-\width]{#1}}
% Fancy quote environments, with nice big colored quotation marks.
\renewenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax%
                \hsmash{\fontsize{20}{22}\color{\thegenrecolor}\selectfont``}%
                }
               {\hfill\smash{\fontsize{20}{22}\color{\thegenrecolor}\selectfont\raisebox{-7pt}{\antihsmash{''}}}%
               \endlist}
\renewenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax%
                \hsmash{\fontsize{20}{22}\color{\thegenrecolor}\selectfont``}%
                }
               {\hfill\smash{\fontsize{20}{22}\color{\thegenrecolor}\selectfont\raisebox{-7pt}{\antihsmash{''}}}%
               \endlist}

% Pullquote with a nice big font.
\renewenvironment{pullquote}{
    \begin{leftbar}
    \noindent
    \raggedright
    \Large\textbf\bgroup\textit\bgroup
    \ignorespaces
    \color{\thegenrecolor}
    \bigfont
}{
    \egroup\egroup
    \par\noindent
    \ignorespacesafterend
    \vspace{-1.3\baselineskip}
    \end{leftbar}
    \vspace{-.5\baselineskip}
}

% Dit is overgenomen van de bonaparticle-class,
% dus check af en toe dat het nog een beetje op elkaar lijkt!

% \chapter (\thetitle en \placetitle)
\titleformat
    {\chapter}[display]
    {
        \pagestyle{bonaparticle}
        \thispagestyle{bonaparticlefirstpage}
        \raggedright
        \fontsize{22}{24}
        \bfseries
        \bigfont
        \vspace{-4.5\baselineskip}
    }
    {}
    {0cm}
    {}


% \chapter*. Let op dat titels van artikelen de variant zonder ster gebruiken!
\titleformat
    {name=\chapter,numberless}[display]
    {
        \raggedright
        \vspace{-8\baselineskip}
        \fontsize{22}{24}
        \bfseries
        \bigfont
    }
    {}
    {0cm}
    {}


% Titels in de inhoudsopgave
\renewcommand{\placetitle}[2]{
    \addtocontents{toc}{
        \hspace{-1.7cm}
        \colorbox{\thegenrecolor}{
            \protect\parbox{.7cm}{
                \vskip4pt
                \hspace{0.7cm}
            }
        }
        \vspace{-.6cm}
        \par
    }
    \chapter[#1]{#2}
    \renewcommand{\and}{ /\ }
    \ifstrempty{\theauthor}{
        \vspace{-\baselineskip}
    }{
        \addtocontents{toc}{{\textit{\small\theauthor}}\vspace{.1cm}\par}
    }
    \renewcommand{\and}{\unskip, }
}

\renewcommand{\maketitle}{
    \placetitle{\theshortenedtitle}{\thetitle}
    {
        \Large
        \bigfont
        \vspace{-2.8\baselineskip}
        \begin{spacing}{1.1}
            \raggedright
            \thesubtitle
        \end{spacing}
        \vspace{0.5\baselineskip}
    }

    {
        \large
        \bigfont
        \theauthor
        \vspace{.5\baselineskip}
    }

}

% \section formatting
\titleformat
    % hang doesn't insert a newline above the section,
    % making them look much better when they're at the top of a page
    {\section}[hang]
    {
        \raggedright
        \fontsize{14}{15}
        \bfseries
        \color{\thegenrecolor}
        \bigfont
    }
    {
        \vspace{-\baselineskip}
    }
    {0cm}
    {
        \thesection
        \quad
    }


% \section* formatting
\titleformat
    {name=\section,numberless}[hang]
    {
        \raggedright
        \fontsize{14}{15}
        \bfseries
        \color{\thegenrecolor}
        \bigfont
    }
    {
        \vspace{-\baselineskip}
    }
    {0cm}
    {}



\renewcommand{\resetbonaparticlehf}{
    \fancyhf{}
    \fancyheadoffset{2.0cm}
    \renewcommand{\headrulewidth}{0pt}
}


% Opmaak voor de headers. Het eerste argument mag leeg zijn, of 'title'. Met dat
% laatste zal de titel bovenaan de pagina worden getoond.
\renewcommand{\makebonaparticleheaders}[1][]{
    % Headers op [E]ven pagina's zijn [L]inks uitgelijnd
    \fancyhead[LE]
    {
        \colorbox{\thegenrecolor}{
            \vrule height7.5pt depth2.4pt width0pt % TeX: iets dikkere colorbox
            \hspace{.75cm}
            \color{white}
            \textbf{\MakeUppercase{\bigfont \thegenre} ~}
        }
        \ifstrequal{#1}{title}{
            \quad
            \color{\theheadercolor}
            \MakeUppercase{\bigfont \leftmark}
        }{}
    }

    % Headers op [O]neven pagina's zijn [R]echts uitgelijnd
    \fancyhead[RO]
    {
        \ifstrequal{#1}{title}{
            \color{\theheadercolor}
            \MakeUppercase{\bigfont \leftmark}
            \quad
        }{}
        \colorbox{\thegenrecolor}{
            \vrule height7.5pt depth2.4pt width0pt % TeX: iets dikkere colorbox
            \color{white}
            \textbf{~ \MakeUppercase{\bigfont \thegenre}}
            \hspace{.75cm}
        }
        \hspace{-5pt}
    }
}


\renewcommand{\makebonaparticlefooters}{
    % Footers op [E]ven pagina's zijn [L]inks uitgelijnd
    \fancyfoot[LE]
    {
        {
            \color{\thefootercolor}
            \small
            \vspace{-2\baselineskip}
            \raggedright
            \textbf{\thepage}
            \quad
            % Voorheen \themagazinename. Die bestandsnaam is zo debiel lang om
            % de kans dat een artikel dit plaatje per ongeluk overschrijft te
            % verkleinen.
            \raisebox{-.5pt}{ % Even goed uitlijnen met paginanummer en uitgave
                \includegraphics[
                    height=\baselineskip
                ]{het-volledige-vakidioot-logo-2019.pdf}
            }
            \quad
            \textbf{\themagazineissue}
        }
        \ifprint
            \begin{picture}(0, 0)(-257,20){}
                \colorbar
            \end{picture}
        \fi
    }

    % Footers op [O]neven pagina's zijn [R]echts uitgelijnd
    \fancyfoot[RO]
    {
        {
            \color{\thefootercolor}
            \small
            \vspace{-2\baselineskip}
            \raggedleft
            \textbf{\themagazinetheme}
            \quad
            % Voorheen \themagazinename. Die bestandsnaam is zo debiel lang om
            % de kans dat een artikel dit plaatje per ongeluk overschrijft te
            % verkleinen.
            \raisebox{-.5pt}{ % Even goed uitlijnen met paginanummer en uitgave
                \includegraphics[height=\baselineskip]{het-volledige-vakidioot-logo-2019.pdf}
            }
            \quad
            \textbf{\thepage}%
        }
        \ifprint
            \begin{wrapfigure}[0]{l}{0cm}
                \begin{picture}(0, 0)(-30,5){}
                    \colorbar
                \end{picture}
            \end{wrapfigure}
        \fi
    }
}


\pagestyle{bonaparticle}




% ---------------------------------------------------------------------------- %




%    C O M M A N D O ' S
%    -------------------
% Commando's die gebruikt kunnen worden voor het invoegen of aanpassen van
% Vakidioot-specifieke elementen. Mocht je een nieuw commando gemaakt hebben dat
% mogelijk in het algemeen wel handig is, dan wordt het gewaardeerd als je die
% in de bonaparticle-class laat opnemen.


% Het \genre-commando zat ook al in de bonaparticle-class, maar we willen hier
% een iets uitgebreidere versie ervan.
%
% Dit commando dient aan het begin van het artikel uitgevoerd te worden. Bij
% voorkeur moet het door je gekozen genre in één van deze ifstrequal-dingen
% staan. De class zorgt er dan voor dat het genrebalkje links- en rechtsboven de
% pagina's, de kopjes, de kaders, en de pullquotes de juiste kleuren krijgen.
%
% Mocht een artikel echter een genre hebben dat duidelijk niet in één van deze 
% voorgedefinieerde genres valt en/of juist een eigen genre verdient, dan kun je
% die aan deze lijst toevoegen, of handmatig met \genrecolor{<kleurnaam>} alsnog
% een kleur eraan toewijzen.
%
%  +- Voorbeeld 1 ------------+
%  |                          |
%  |  \genre{Informatica}     |    Dit zal de genrekleur op donkerrood zetten.
%  |                          |
%  +--------------------------+
%
%  +- Voorbeeld 2 ------------+
%  |                          |
%  |  \genre{Marco Borsato}   |    Overigens is "Marco Borsato" niet zo'n heel
%  |  \genrecolor{Rood}       |    goede genrenaam, maar dit terzijde.
%  |                          |
%  +--------------------------+
\let\bonaparticlegenre\genre
\renewcommand{\genre}[1]{
    % Dit zal nu links- en rechtsboven komen te staan in een gekleurd blokje
    % komen te staan. Welke kleur dat blokje heeft, bepalen we hieronder.
    \bonaparticlegenre{#1}

    % A-Eskwadraat (geel)
    \ifstrequal{#1}{A--Eskwadraat}{
        \genrecolor{aesrood}
    }{}
    \ifstrequal{#1}{\aesnaam}{
        \genrecolor{aesrood}
    }{}
    \ifstrequal{#1}{A--Eskwadrater in het Buitenland}{
        \genrecolor{aesrood}
    }{}
    \ifstrequal{#1}{Activiteit}{
        \genrecolor{aesrood}
    }{}
    \ifstrequal{#1}{Vakidioot}{
        \genrecolor{aesrood}
    }{}

    % Idioot (paars)
    \ifstrequal{#1}{Column}{
        \genrecolor{idiootpaars}
    }{}
    \ifstrequal{#1}{Opinie}{
        \genrecolor{idiootpaars}
    }{}
    \ifstrequal{#1}{Puzzel}{
        \genrecolor{idiootpaars}
    }{}
    \ifstrequal{#1}{Infographic}{
        \genrecolor{idiootpaars}
    }{}
    \ifstrequal{#1}{Cartoon}{
        \genrecolor{idiootpaars}
    }{}
    \ifstrequal{#1}{Idioot}{
        \genrecolor{idiootpaars}
    }{}

    % Informatica (rood)
    \ifstrequal{#1}{Informatica}{
        \genrecolor{incarood}
    }{}
    \ifstrequal{#1}{Computer Science}{
        \genrecolor{incarood}
    }{}
    \ifstrequal{#1}{Gametechnologie}{
        \genrecolor{incarood}
    }{}
    \ifstrequal{#1}{Informatica/-ekunde}{
        \genrecolor{incarood}
    }{}
    \ifstrequal{#1}{Computer and Information Science}{
        \genrecolor{incarood}
    }{}

    % Informatiekunde (oranje)
    \ifstrequal{#1}{Informatiekunde}{
        \genrecolor{inkuoranje}
    }{}
    \ifstrequal{#1}{Information Science}{
        \genrecolor{inkuoranje}
    }{}
    \ifstrequal{#1}{Data Science}{
        \genrecolor{inkuoranje}
    }{}

    % Natuurkunde (blauw)
    \ifstrequal{#1}{Natuurkunde}{
        \genrecolor{natkblauw}
    }{}
    \ifstrequal{#1}{Sterrenkunde}{
        \genrecolor{natkblauw}
    }{}
    \ifstrequal{#1}{Physics}{
        \genrecolor{natkblauw}
    }{}
    \ifstrequal{#1}{Astronomy}{
        \genrecolor{natkblauw}
    }{}

    % Wiskunde (groen)
    \ifstrequal{#1}{Wiskunde}{
        \genrecolor{wiskgroen}
    }{}
    \ifstrequal{#1}{Mathematics}{
        \genrecolor{wiskgroen}
    }{}

    % Studeren en medezeggenschap enzo (geel)
    \ifstrequal{#1}{Onderwijs}{
        \genrecolor{uugeel}
    }{}
    \ifstrequal{#1}{Studie}{
        \genrecolor{uugeel}
    }{}
    \ifstrequal{#1}{Universiteit}{
        \genrecolor{uugeel}
    }{}
    \ifstrequal{#1}{Medezeggenschap}{
        \genrecolor{uugeel}
    }{}

    % Al het andere (roze)
    \ifstrequal{#1}{Overig}{
        \genrecolor{overigroze}
    }{}
    \ifstrequal{#1}{Nieuws}{
        \genrecolor{overigroze}
    }{}
    
    % Algemene vakartikelen (blauw)
    \ifstrequal{#1}{Vak}{
        \genrecolor{vakblauw}
    }{} 
    \ifstrequal{#1}{Geschiedenis}{
        \genrecolor{vakblauw}
    }{}

   % Reclame enzo (zwart)
    \ifstrequal{#1}{Advertorial}{
        \genrecolor{black}
    }{}
}


% Hiermee stel je respectievelijk de datum van uitgave, oplage, en deadline voor
% inzendingen voor het volgende nummer in. De placeholderwaarden hiervoor zijn
% een stuk hierboven terug te vinden.
\newcommand{\uitgave}[1]{
    \renewcommand{\theuitgave}{#1}
}

\newcommand{\oplage}[1]{
    \renewcommand{\theoplage}{#1}
}

\newcommand{\deadline}[1]{
    \renewcommand{\thedeadline}{#1}
}


% De fotostrip wordt op dezelfde manier geplaatst als advertenties, maar i.t.t.
% advertenties willen we deze wel in de inhoudsopgave kunnen terugvinden. Zie
% ook \fullpagefeaturedimage in de bonaparticle-class.
%
% Een fotostrip invoegen met "De Fotostrip" als titel in de inhoudsopgave:
%
%  +- Voorbeeld -----------------------+
%  |                                   |
%  |  \fotostrip{fotostrip.png}{5}{5}  |
%  |                                   |
%  +-----------------------------------+
%
% Een fotostrip invoegen met een andere titel dan "De Fotostrip":
%
%  +- Voorbeeld ----------------------------------------------------+
%  |                                                                |
%  |  \fotostrip[The Making Of the Fotostrip]{fotostrip.png}{5}{5}  |
%  |                                                                |
%  +----------------------------------------------------------------+
\newcommand{\fotostrip}[4][De Fotostrip]{
    \clearpage
    \author{}
    \genrecolor{idiootpaars}
    \begin{minipage}{\paperwidth}
        \placetitle{#1}{}
        \includepdf[
            noautoscale,
            width=\paperwidth+#3mm,
            height=\paperheight+#4mm
        ]
        {#2}
    \end{minipage}
}


% Handige aliassen voor het opstellen van lijsten van redactieleden en andere
% mensen die we willen bedanken. Je kunt de namen het beste van elkaar scheiden
% met een \and.
%
%  +- Voorbeeld --------------+
%  |                          |
%  |  \begin{redactie}        |
%  |      Kwik \and           |
%  |      Kwek \and           |
%  |      Kwak                |
%  |  \end{redactie}          |
%  |                          |
%  +--------------------------+

% Neem hierin je lijst met redactieleden op.
\newenvironment{redactie}{
    \begin{colophon}{Redactie}
}{
    \end{colophon}
    ~\\
}


% Neem hierin je eindredactie op. Deze namen hoeven niet ook voor te komen in de
% lijst met gewone redactieleden.
\newenvironment{eindredactie}{
    \begin{colophon}{Eindredactie}
}{
    \end{colophon}
    ~\\
}


% De auteur of organisatie die de omslagafbeelding heeft gemaakt. Indien een
% eindredacteur de omslag heeft gemaakt, hoeft zijn/haar naam hier niet nog een
% keer genoemd te worden (en kan de hele omslag-environment weggelaten worden).
\newenvironment{omslag}{
    \begin{colophon}{Omslag}
}{
    \end{colophon}
    ~\\
}


% Hierin noem je alle mensen, commissies, en organisaties die bijgedragen hebben
% aan de totstandkoming van de Vakidioot, maar die niet in de inhoudsopgave
% genoemd worden. Dit zal in de praktijk vooral de ViCie zijn.
% Let op dat rechthebbenden van beeldmateriaal hier niet onder vallen; die
% dienen bedankt te worden met het \imagecopyright-commando.
\newenvironment{metdankaan}{
    \begin{colophon}{Met dank aan}
}{
    \end{colophon}
    ~\\
}


% Met de redactioneel-environment gebruik je om het... <voeg drumroll hier in>
% redactioneel op te maken. Op deze pagina is naast het redactioneel ook het
% colofon te vinden. Mocht je daar meer in geïnteresseerd zijn, dan kun je beter
% bij de definitie van \colofon kijken.
%
% +- Voorbeeld --------------------------------------------+
% |                                                        |
% |  \uitgave {30 november 2015}                           |
% |  \oplage  {2250}                                       |
% |  \deadline{5 december 2015}                            |
% |                                                        |
% |  \begin{redactioneel}                                  |
% |      Ik heb een hamer. Zo af en toe schrijf ik ook.    |
% |      Maar meestal hamer ik. Want ik heb toch een       |
% |      hamer.\\                                          |
% |                                                        |
% |      Lisette Hamer,\\                                  |
% |      \textit{hoofdredacteur}                           |
% |  \end{redactioneel}                                    |
% |                                                        |
% +--------------------------------------------------------+ 
\newenvironment{redactioneel}{
    \begin{wrapfigure}[100]{l}{5.4cm}
        \begin{minipage}[t]{4.7cm}
        \colofon
        \end{minipage}
    \end{wrapfigure}

    \begin{editorial}
        \title{Redactioneel}
        \chapter*{\hspace{5.8cm} \thetitle}
        \vspace{-2.5\baselineskip} % Anders krijg je een flinke witruimte
}
    % <En hier komt dan het redactioneel>
{
    \end{editorial}
}


%    C o l o f o n
%    - - - - - - -
% Dit commando zet de colofondeelpagina in elkaar. Dat bestaat onder meer uit
% een lijstje van publicatiegegevens (oplage, datums, enz.), contactgegevens van
% A-Eskwadraat, en de lijst met mensen die mee gewerkt hebben aan dit nummer.
% Die lijst moet in een bestand Colofon.tex (let op de hoofdletter) staan, in
% dezelfde map als het hoofdbestand. De datum van uitgave, oplage, en de
% volgende deadline kunnen worden ingesteld met een drietal commando's.
%
% In principe hoef je dit commando nooit zelf aan te roepen (zie ook de
% redactioneel-environment).
%
%  +- Voorbeeld -------------------+
%  |                               |
%  |  \uitgave {30 november 2015}  |
%  |  \oplage  {2250}              |
%  |  \deadline{5 december 2015}   |
%  |                               |
%  |  \colofon                     |
%  |                               |
%  +-------------------------------+
%
%  +- Voorbeeld Colofon.tex ---+
%  |                           |
%  |  \begin{redactie}         |
%  |      Ans de Nijs          |
%  |      Claudia Wieners      |
%  |      Jacco Krijnen        |
%  |      Marjolein Troost     |
%  |      Suze Bloks           |
%  |      Tim Coopmans         |
%  |  \end{redactie}           |
%  |                           |
%  |  \begin{eindredactie}     |
%  |      Adinda de Wit        |
%  |      Darius Keijdener     |
%  |      Lars van den Berg    |
%  |  \end{eindredactie}       |
%  |                           |
%  |  \begin{omslag}           |
%  |      Tim Neutel           |
%  |  \end{omslag}             |
%  |                           |
%  |  \begin{metdankaan}       |
%  |      Adolf Kitler         |
%  |      Angela Meowkel       |
%  |      Benito Meowsolini    |
%  |      Fidel Catstro        |
%  |      George W. Puss       |
%  |      Jan-Peter Pawkenende |
%  |      Kim Jong-Mew         |
%  |      Meowgustus Caesar    |
%  |      Meow Tse Tung        |
%  |      Meowseph Stalin      |
%  |      Pawrack Obama        |
%  |      Purr Pot             |
%  |      Robert Meowgabe      |
%  |      Vladimew Lenin       |
%  |      Vladimew Pawtin      |
%  |      Winston Purrchill    |
%  |  \end{metdankaan}         |
%  |                           |
%  +---------------------------+
\newcommand{\colofon}{
    \small

    \textbf{Uitgave}  \hfill \theuitgave \\
    \textbf{Oplage}   \hfill \theoplage  \\
    \textbf{Deadline} \hfill \thedeadline\\

    \textbf{De Vakidioot is een uitgave van}\\
    Studievereniging \aesnaam\\
    Princetonplein 5\\
    3584 CC~~Utrecht\\

    \textbf{Telefoon} \hfill (030) 253 4499\\
                                       % Wat extra miniwitruimtes om
                                       % de uitlijnings-OCD-autisten onder
                                       % ons gerust te stellen: dit lijnt het
                                       % faxnummer uit met het telefoonnummer.
    \textbf{Fax}      \hfill (030) 253 5\hspace{.4pt}7\hspace{.4pt}8\hspace{.4pt}7\hspace{.2pt}~\\
    \textbf{Website}  \hfill a-eskwadraat.nl/vakid\\
    \textbf{E-mail}   \hfill vakid@a-eskwadraat.nl\\
    
    Wil je de Vakidioot niet meer ontvangen of ben je verhuisd? Pas dan je gegevens aan op \url{a-eskwadraat.nl}. \\

    % Dit bestandje moet je dus wel even in dezelfde map zetten als het
    % hoofdbestand, anders doet-ie niet zoveel (maar dat stond hierboven ook al)
    \input{Colofon.tex}
}


% Maakt een dummypagina aan. Er zijn meerdere use cases voor het invoegen van
% een dummypagina; de meest voorkomende zijn als placeholder voor een artikel
% dat nog afgerond moet worden (of zelfs nog binnen moet komen), of als
% hulpmiddel om (het echte deel van) een artikel bij het opmaken tijdelijk
% geforceerd op een linkerpagina te laten beginnen.
\newcommand{\dummypagina}{
    \fakepage
}



% Floating infobox: maakt een infobox, maar dan floating. Leuk! Gebruikt drie argumenten: de breedte, de horizontale positie en de verticale positie. De posities worden ingevoerd als een getal tussen 0 en 1 (wordt vermenigvuldigd met de pagina-dimensies).

\PassOptionsToPackage{overlay,absolute}{textpos}
\RequirePackage{textpos}

\newenvironment{floatinginfobox}[3]{
	\begin{textblock*}{#1}(#2\paperwidth,#3\paperheight)
		\begin{lrbox}{\coloredbox}
			\begin{minipage}{#1}
				\vskip10pt
				\leftskip10pt\rightskip10pt
				\color{white}
				\begin{spacing}{1.15}
				}{
				\end{spacing}
				~\vskip10pt
			\end{minipage}
		\end{lrbox}%
		\begin{center}
			\colorbox{\thegenrecolor}{
				\usebox{\coloredbox}
			}
		\end{center}
	\end{textblock*}
}

% Transparante versie van de floating infobox

\newenvironment{floatinginfoboxtransparent}[3]{
	\begin{textblock*}{#1}(#2\paperwidth,#3\paperheight)
		\begin{minipage}{#1}
			\vskip10pt
			\leftskip10pt\rightskip10pt
			\color{white}
			\begin{spacing}{1.15}
			}{
			\end{spacing}
			~\vskip10pt
		\end{minipage}
	\end{textblock*}
}




% ---------------------------------------------------------------------------- %




%                       .               ,.
%                      T."-._..---.._,-"/|
%                      l|"-.  _.v._   (" |
%                      [l /.'_ \; _~"-.`-t
%                      Y " _(o} _{o)._ ^.|
%                      j  T  ,-<v>-.  T  ]
%                      \  l ( /-^-\ ) !  !
%                       \. \.  "~"  ./  /c-..,__
%                         ^r- .._ .- .-"  `- .  ~"--.
%                          > \.                      \
%                          ]   ^.                     \
%                          3  .  ">            .       Y 
%             ,.__.--._   _j   \ ~   .         ;       |
%            (    ~"-._~"^._\   ^.    ^._      I     . l
%             "-._ ___ ~"-,_7    .Z-._   7"   Y      ;  \        _
%                /"   "~-(r r  _/_--._~-/    /      /,.--^-._   / Y
%                "-._    '"~~~>-._~]>--^---./____,.^~        ^.^  !
%                    ~--._    '   Y---.                        \./
%                         ~~--._  l_   )                        \
%                               ~-._~~~---._,____..---           \
%                                   ~----"~       \
%                                                  \
\endinput

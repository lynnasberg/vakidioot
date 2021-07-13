/*
*
* Door deze C++ code uit te voeren kun je een .tex bestand met contactgegevens
* van de abonnees van de Vakidioot converteren naar een .csv bestand, met in
* de eerste kolom de namen van de abonnees, in de tweede kolom de straat +
* het huisnummer, en in de derde kolom de postcode en plaatsnaam (en
* land wanneer het niet in Nederland ligt).
*
* De code probeert zo veel mogelijk fouten te verbeteren en latex-commando's
* om te zetten in speciale tekens waar mogelijk. Als dit niet lukt zal het
* programma vragen om handmatige input.
*
* Uiteindelijk moet je dit CSV bestand openen in Excel om het te exporteren
* als .xlsx bestand. Check ook nog even handmatig of alles lijkt te kloppen!
* 
* Het zou zomaar kunnen dat in de toekomst de indeling van het .tex bestand
* verandert, waardoor deze code niet meer (goed) werkt. Voel je vrij om het
* dan aan te passen. Als je hier hulp nodig bij hebt, schroom dan niet om
* contact met mij op te nemen via lynnasberg@gmail.com!
*
* Het compileren van deze code naar een uitvoerbaar bestand kun je het
* makkelijkst doen d.m.v. g++, zie ook https://www.geeksforgeeks.org/compiling-with-g-plus-plus/
*
* Geschiedenis:
* - 2020-04-06 Aangemaakt door Lynn Asberg
* - 2021-07-13 Fixes + uitleg over G++ toegevoegd
*
*/

#include <sstream>
#include <fstream>
#include <string>
#include <vector>
#include <iterator>
#include <iostream>

enum class addressType {
	PERSOON,
	CONTACT,
	UNDEFINED
};

std::vector <std::string> splitString(std::string str, std::string delimiter)
{
	std::vector <std::string> split;
	size_t pos = 0;
	std::string token;
	while ((pos = str.find(delimiter)) != std::string::npos) {
		token = str.substr(0, pos);
		split.push_back(token);
		str.erase(0, pos + delimiter.length());
	}
	split.push_back(str);

	return split;
}

// from https://stackoverflow.com/questions/3418231/replace-part-of-a-string-with-another-string
void replace(std::string& str, const std::string& from, const std::string& to) {
	while (true)
	{
		size_t start_pos = str.find(from);
		if (start_pos == std::string::npos) break;
		str.replace(start_pos, from.length(), to);
	}
}

void getUserInput(std::string& field, std::string fieldname, std::string errorMessage, std::string additionalInfo)
{
	std::cout << "**** ERROR: " << errorMessage << " " << fieldname << ":" << std::endl;
	std::cout << "** " << field << std::endl;
	std::cout << "** Additional info: " + additionalInfo << std::endl;
	std::cout << "** Please input corrected version:" << std::endl;
	std::getline(std::cin, field);

	std::string check = "n";
	while (check == "n")
	{
		std::cout << "** Provided input: " << field << std::endl;
		std::cout << "** Is this correct? (y/n): ";
		std::cin >> check;
		std::cout << std::endl;
		while (!(check == "n" || check == "y"))
		{
			std::cout << "** Please enter either y (yes) or n (no): ";
			std::cin.ignore();
			std::cin >> check;
		}

		if (check == "n")
		{
			std::cout << "** Please input corrected version:" << std::endl;
			std::cin.ignore();
			std::getline(std::cin, field);
		}
	}
	std::cin.ignore();
	std::cout << std::endl;
}

void replaceLatexCommands(std::string& str)
{
	// vervang een latex commando door het teken dat het representeert.
	// voeg hier vooral wat aan toe als je iets nieuws tegenkomt!
	// let op: een backslach schrijf je als \\ en " als \"
	replace(str, "\\\"{a}", "ä");
	replace(str, "\\\"{e}", "ë");
	replace(str, "\\\"{i}", "ï");
	replace(str, "\\\"{u}", "ü");
	replace(str, "\\\"{o}", "ö");
	replace(str, "\\\"{y}", "ÿ");

	replace(str, "\\\'{a}", "á");
	replace(str, "\\\'{e}", "é");
	replace(str, "\\\'{i}", "í");
	replace(str, "\\\'{u}", "ú");
	replace(str, "\\\'{o}", "ó");
	replace(str, "\\\'{y}", "ý");

	replace(str, "\\`{a}", "à");
	replace(str, "\\`{e}", "è");
	replace(str, "\\`{i}", "ì");
	replace(str, "\\`{u}", "ù");
	replace(str, "\\`{o}", "ò");

	replace(str, "\\c{c}", "ç");
	replace(str, "\\c{C}", "Ç");
	replace(str, "\\&", "&");
	replace(str, "\\{AA}", "Å");
	replace(str, "\\{aa}", "å");
	replace(str, "\\~{n}", "ñ");
}

int main()
{	
	// working directory
	std::cout << "**** Please specify working directory:" << std::endl;
	std::string path;
	std::getline(std::cin, path);
	std::cout << std::endl;
	replace(path, "\\", "/");
	if (path.at(path.length() - 1) == '/') path.erase(path.length() - 1, 1);

	// input file
	std::cout << "**** Please specify input file name (ending in .tex):" << std::endl;
	std::string filename;
	std::getline(std::cin, filename);
	std::cout << std::endl;

	std::ifstream infile(path + "/" + filename);

	// output file
	std::cout << "**** Please specify output file name (ending in .csv):" << std::endl;
	std::string outputfilename;
	std::getline(std::cin, outputfilename);
	std::cout << std::endl;

	std::ofstream outfile;
	outfile.open(path + "/" + outputfilename);
	int linesWritten = 0;

	// read file
	std::string line;
	int lineNumber = 0;
	while (std::getline(infile, line))
	{
		lineNumber++;
		std::istringstream iss(line);

		addressType atype = addressType::UNDEFINED;

		if (line.substr(0, 9) == "\\persoon{") atype = addressType::PERSOON;
		if (line.substr(0, 9) == "\\contact{") atype = addressType::CONTACT;

		if (atype == addressType::UNDEFINED)
		{
			std::cout << "Error at line " << lineNumber << ": undefined command " << line.substr(0, 9) << ", must be either \\person or \\contact" << std::endl;
			continue;
		}

		std::vector<std::string> split = splitString(line.substr(9, line.length() - 10), "}{");

		std::string name;
		std::string address1;
		std::string address2;


		// Person
		if (atype == addressType::PERSOON)
		{
			if (split.size() != 9)
			{
				std::cout << "ERROR at line " << lineNumber << ": counted " << split.size() << " fields instead of the required 9 for \\person." << std::endl;
				continue;
			}

			name = split[0] + " " + split[2] + " " + split[3];
			address1 = split[6];
			address2 = split[7];

			// check if there are any commas in strings, if so promt the user to manually correct them
			if (name.find(',') != std::string::npos) getUserInput(name, "name", "Comma found in", "");
			if (address1.find(',') != std::string::npos) getUserInput(address1, "address line 1", "Comma found in", "");
			if (address2.find(',') != std::string::npos) getUserInput(address2, "address line 2", "Comma found in", "");
		}


		// Contact
		if (atype == addressType::CONTACT)
		{
			if (split.size() != 4)
			{
				std::cout << "ERROR at line " << lineNumber << ": counted " << split.size() << " fields instead of the required 4 for \\contact." << std::endl;
				continue;
			}

			if (split[1].size() > 0) name = split[0] + ", t.a.v. " + split[1];
			else name = split[0];

			std::vector<std::string> splitAddress = splitString(split[2], "\\\\");

			if (splitAddress.size() != 2)
			{
				std::cout << "ERROR at line " << lineNumber << ": counted " << splitAddress.size() << " address lines instead of the required 2 for \\contact." << std::endl;
				continue;
			}

			address1 = splitAddress[0];
			address2 = splitAddress[1];
		}


		// no name or incomplete address -> do not add to file
		if (name == "" || address1 == "" || address2 == "")
			continue;


		// remove Netherlands from the address, not necessary
		replace(address2, " Nederland", "");
		replace(address2, "Nederland", "");
		replace(address2, " NEDERLAND", "");
		replace(address2, "NEDERLAND", "");
		replace(address2, " nederland", "");
		replace(address2, "nederland", "");

		replace(address2, " The Netherlands", "");
		replace(address2, "The Netherlands", "");
		replace(address2, " THE NETHERLANDS", "");
		replace(address2, "THE NETHERLANDS", "");
		replace(address2, " the netherlands", "");
		replace(address2, "the netherlands", "");
		
		replace(address2, " Netherlands", "");
		replace(address2, "Netherlands", "");
		replace(address2, " NETHERLANDS", "");
		replace(address2, "NETHERLANDS", "");
		replace(address2, " netherlands", "");
		replace(address2, "netherlands", "");


		// replace double spaces by single spaces
		replace(name, "  ", " ");
		replace(address1, "  ", " ");
		replace(address2, "  ", " ");


		// incomplete address, only postal code
		if (address2.length() < 8) getUserInput(address2, "address line 2", "Incomplete address in", "Address line 1: " + address1);


		// Fix formatting of postal code, if it a Dutch postal code
		if (
			(isdigit(address2.at(0)) &&
				isdigit(address2.at(1)) &&
				isdigit(address2.at(2)) &&
				isdigit(address2.at(3)) &&

				isspace(address2.at(4)) &&

				isalpha(address2.at(5)) &&
				isalpha(address2.at(6)) &&
				isspace(address2.at(7)))
			||
			(isdigit(address2.at(0)) &&
				isdigit(address2.at(1)) &&
				isdigit(address2.at(2)) &&
				isdigit(address2.at(3)) &&

				isalpha(address2.at(4)) &&
				isalpha(address2.at(5)) &&
				isspace(address2.at(6))))
		{
			// it's a Dutch postal code, reformat correctly
			if (isspace(address2.at(4))) address2.erase(4, 1);
			address2.replace(4, 1, 1, toupper(address2.at(4)));
			address2.replace(5, 1, 1, toupper(address2.at(5)));
		}


		// capitalize the first letter of the address
		address1.replace(0, 1, 1, toupper(address1.at(0)));


		// interpret latex commands
		replaceLatexCommands(name);
		replaceLatexCommands(address1);
		replaceLatexCommands(address2);
		if (name.find('\\') != std::string::npos) getUserInput(name, "name", "Unknown Latex command found in", "");
		if (address1.find('\\') != std::string::npos) getUserInput(address1, "address line 1", "Unknown Latex command found in", "");
		if (address2.find('\\') != std::string::npos) getUserInput(address2, "address line 2", "Unknown Latex command found in", "");
		

		// export to CSV file
		outfile << "\"" << name << "\",\"" << address1 << "\",\"" << address2 << "\"\n";
		linesWritten++;
	}

	outfile.close();
	std::cout << std::endl;
	std::cout << "**** Done! Output was written to " + path + "/" + outputfilename << std::endl;
	std::cout << "** Oplage: " << linesWritten << std::endl;
	std::cout << std::endl;
	std::cout << "Press return (enter) to close this window." << std::endl;
	std::cin.get();
	return 0;
}
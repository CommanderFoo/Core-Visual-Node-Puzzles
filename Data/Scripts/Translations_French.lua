local translations = {}

-- translations[""] = ""

translations["Node_Data"] = "Données"
translations["Node_Output"] = "Sortir"
translations["Node_Ordered_Output"] = "Sortie ordonnée"
translations["Node_If_Else"] = "Sinon"
translations["Node_Alternate"] = "Alterner"
translations["Node_Limit"] = "Limite"
translations["Node_Halt"] = "Arrêt"
translations["Node_Greater_Than"] = "Plus grand que"
translations["Node_Absolute"] = "Absolue"
translations["Node_Add"] = "Ajouter"
translations["Node_Multiply"] = "Multiplier"
translations["Node_Subtract"] = "Soustraire"
translations["Node_Reroute"] = "Changer"
translations["Node_View"] = "Vue"

translations["Node_Name_Data"] = translations["Node_Data"]
translations["Node_Name_Output"] = translations["Node_Output"]
translations["Node_Name_Ordered_Output"] = translations["Node_Ordered_Output"]
translations["Node_Name_If_Else"] = translations["Node_If_Else"]
translations["Node_Name_Alternate"] = translations["Node_Alternate"]
translations["Node_Name_Limit"] = translations["Node_Limit"]
translations["Node_Name_Halt"] = translations["Node_Halt"]

translations["Node_Name_Math_Data"] = translations["Node_Data"]
translations["Node_Name_Math_Output"] = translations["Node_Output"]
translations["Node_Name_Math_Alternate"] = translations["Node_Alternate"]
translations["Node_Name_Math_Greater_Than"] = translations["Node_Greater_Than"]
translations["Node_Name_Math_Absolute"] = translations["Node_Absolute"]
translations["Node_Name_Math_Add"] = translations["Node_Add"]
translations["Node_Name_Math_Multiply"] = translations["Node_Multiply"]
translations["Node_Name_Math_Subtract"] = translations["Node_Subtract"] 

translations["Node_Name_Misc_View"] = translations["Node_View"]

translations["Square"] = "Carré"
translations["Circle"] = "Cercle"
translations["Plus"] = "Plus"
translations["Triangle"] = "Triangle"

translations["Logic_Puzzles_Button"] = "PUZZLES LOGIQUES"
translations["Math_Puzzles_Button"] = "PUZZLES DE MATHÉMATIQUES"
translations["Tutorial_Button"] = "DIDACTICIEL"
translations["Glossary_Button"] = "GLOSSAIRE DE NOEUDS"
translations["Donate_Button"] = "DONNER UN POURBOIRE"
translations["Settings_Button"] = "LES PARAMÈTRES"
translations["Play_Logic"] = "JOUER"
translations["Select_Logic"] = "SÉLECTIONNER"
translations["Play_Math"] = "JOUER"
translations["Select_Math"] = "SÉLECTIONNER"

translations["Donate_Title"] = "DONNER UN POURBOIRE"
translations["Donate_Body"] = "Donner des pourboires est totalement facultatif et n'affecte en aucun cas le gameplay. Tous les conseils sont très appréciés."

translations["Logic_List_Title"] = "LISTE DE PUZZLES LOGIQUES"
translations["Math_List_Title"] = "LISTE DE PUZZLES MATHÉMATIQUES"

translations["Glossary_Title"] = "GLOSSAIRE DE NOEUDS"
translations["Glossary_Logic_Nodes"] = "LOGIQUE"
translations["Glossary_Data_Node_Title"] = "LES DONNÉES"
translations["Glossary_Data_Node_Desc"] = "Le nœud de données contient les données du puzzle. Il peut avoir plusieurs types de données. L'ordre de sortie n'est pas garanti."
translations["Glossary_Output_Node_Title"] = "SORTIR"
translations["Glossary_Output_Node_Desc"] = "Le nœud de sortie est également l'endroit où les données sont envoyées. Certains nœuds de sortie peuvent nécessiter plusieurs types de données et doivent respecter la quantité requise."
translations["Glossary_Ordered_Output_Node_Title"] = "SORTIE COMMANDÉE"
translations["Glossary_Ordered_Output_Node_Desc"] = "Agit comme le nœud de sortie, mais l'ordre des données doit être respecté. Le numéro au-dessus du symbole est l'ordre dans lequel il doit être reçu. Utilisé avec les nœuds d'arrêt."
translations["Glossary_If_Else_Node_Title"] = "SINON"
translations["Glossary_If_Else_Node_Desc"] = "Le nœud If Else vous permet de comparer l'entrée à la valeur sélectionnée dans la liste déroulante. Si la condition est vraie, les données seront envoyées vers le haut. Sinon, il sera envoyé vers le bas."
translations["Node_If_Else_Else"] = "Autre"
translations["Node_If_Else_Square"] = "Carré"
translations["Glossary_Alternate_Node_Title"] = "ALTERNER"
translations["Glossary_Alternate_Node_Desc"] = "Le nœud alternatif alternera les données entrantes entre les sorties supérieure et inférieure."
translations["Glossary_Limit_Node_Title"] = "LIMITE"
translations["Glossary_Limit_Node_Desc"] = "Le nœud limite limitera les données entrantes passant par la sortie supérieure en fonction du nombre limite défini. Une fois le nombre limite atteint, les données entrantes seront envoyées à la sortie inférieure."
translations["Glossary_Halt_Node_Title"] = "ARRÊT"
translations["Glossary_Halt_Node_Desc"] = "Le nœud d'arrêt arrêtera l'envoi de données au nœud de sortie. C'est le seul nœud qui doit être directement connecté à un nœud de sortie. Le numéro en haut à gauche du nœud, indique l'ordre. Ceci est utile lorsque plus d'un nœud d'arrêt est connecté."

translations["Glossary_Math_Nodes"] = "Mathématiques"
translations["Glossary_Math_Data_Node_Title"] = "LES DONNÉES"
translations["Glossary_Math_Data_Node_Desc"] = "Le nœud de données contient les données du puzzle. Il peut avoir plusieurs numéros. L'ordre de sortie n'est pas garanti."
translations["Glossary_Math_Output_Node_Title"] = "SORTIR"
translations["Glossary_Math_Output_Node_Desc"] = "Le nœud de sortie est également l'endroit où les données sont envoyées. Certains nœuds de sortie peuvent nécessiter plusieurs nombres et doivent correspondre au montant requis."
translations["Glossary_Math_Alternate_Node_Title"] = "ALTERNER"
translations["Glossary_Math_Alternate_Node_Desc"] = "Le nœud alternatif alternera les données numériques entrantes entre les sorties supérieure et inférieure."
translations["Glossary_Math_Greater_Than_Node_Title"] = "PLUS GRAND QUE"
translations["Glossary_Math_Greater_Than_Node_Desc"] = "Le nœud Supérieur à vérifie les données numériques entrantes par rapport à la valeur définie. Si les données sont plus grandes, elles seront envoyées par la sortie supérieure, sinon par la sortie inférieure. Maintenir Shift tout en ajustant la valeur augmentera ou diminuera de 5."
translations["Glossary_Math_Absolute_Node_Title"] = "ABSOLUE"
translations["Glossary_Math_Absolute_Node_Desc"] = "Le nœud absolu affichera la valeur absolue des données numériques. Par exemple, -25 deviendra 25."
translations["Glossary_Math_Add_Node_Title"] = "AJOUTER"
translations["Glossary_Math_Add_Node_Desc"] = "Le nœud d'ajout ajoutera les données numériques entrantes en haut et en bas et produira les données numériques additionnées. Cela prend en charge les nombres négatifs."
translations["Glossary_Math_Multiply_Node_Title"] = "MULTIPLIER"
translations["Glossary_Math_Multiply_Node_Desc"] = "Le nœud de multiplication multipliera les données numériques entrantes supérieures et inférieures et les produira multipliées. Cela prend en charge les nombres négatifs."
translations["Glossary_Math_Subtract_Node_Title"] = "Soustraire"
translations["Glossary_Math_Subtract_Node_Desc"] = "Le nœud de soustraction enlèvera les données numériques inférieures des données numériques supérieures et les affichera. Cela prend en charge les nombres négatifs."

translations["Glossary_Misc_Nodes"] = "AUTRE"
translations["Glossary_Misc_Reroute_Node_Title"] = "CHANGER"
translations["Glossary_Misc_Reroute_Node_Desc"] = "Le nœud Direct vous permet de ranger votre graphique en redirigeant les fils du connecteur. Ce nœud n'affecte pas le score du puzzle."
translations["Glossary_Misc_View_Node_Title"] = "VUE"
translations["Glossary_Misc_View_Node_Desc"] = "Le nœud de vue vous aide à déboguer votre programme en voyant quelle est la sortie d'un autre nœud. Ce nœud interrompt le programme, ce qui signifie qu'il ne se terminera pas, il doit donc être déconnecté une fois terminé. Ce nœud n'affecte pas le score du puzzle."

translations["Settings_Title"] = "Paramètres"
translations["Sound_Effects_Volume"] = "Volume des effets sonores"
translations["Music_Volume"] = "Volume de la musique"
translations["Select_Language"] = "Langue"
translations["Save_Button"] = "Enregistrer les paramètres"
translations["Close_Button"] = "Fermer les paramètres"

translations["Puzzle"] = "Puzzle"
translations["PUZZLE"] = "PUZZLE"
translations["Score"] = "Score d'énigme"

translations["Tutorial_Exit"] = "Sortir"
translations["Tutorial_Next"] = "Prochaine"
translations["Tutorial_Welcome_Title"] = "DIDACTICIEL"
translations["Tutorial_Welcome_Msg"] = "Ce tutoriel couvrira les bases de l'interface utilisateur. Il expliquera les commandes d'en-tête supérieures ainsi que les bases mêmes des nœuds.\n\nSi vous n'êtes pas sûr du fonctionnement d'un nœud, consultez le glossaire des nœuds dans le menu principal qui explique tous les nœuds en détail."
translations["Tutorial_Main_Menu"] = "Vous ramène au menu principal."
translations["Tutorial_Awards"] = "Prix ​​actuel qui se met à jour lorsque le programme est en cours d'exécution."
translations["Tutorial_Speed"] = "Contrôle la vitesse du programme. Ralentir la vitesse du programme est utile lorsque vous devez déboguer le transfert de données."
translations["Tutorial_Run"] = "Exécutez ou modifiez votre programme. Lorsque votre programme est en cours d'exécution, les nœuds ne peuvent pas être modifiés."
translations["Tutorial_Show_Nodes"] = "Afficher ou masquer les nœuds du puzzle actuel. Au fur et à mesure que vous progressez, plus de nœuds seront disponibles à utiliser."
translations["Tutorial_Save"] = "Vous permet de sauvegarder la progression actuelle du puzzle. Une seule progression du puzzle peut être sauvegardée. L'enregistrement automatique est activé."
translations["Tutorial_Center"] = "Centre le graphique (raccourci F)."
translations["Tutorial_Clear"] = "Efface tous les nœuds sur le graphe de nœuds."
translations["Tutorial_Nodes"] = "Les nœuds disponibles pour le puzzle apparaîtront ici. Cliquer sur le nœud l'ajoutera au centre du graphique."
translations["Tutorial_Data_Node_Dummy"] = "Données"
translations["Tutorial_Data_Node_Info"] = "Les nœuds de données contiennent les données qui doivent être envoyées aux nœuds de sortie. Vous pouvez faire glisser ces nœuds en cliquant et en maintenant enfoncé le bouton gauche de la souris sur l'en-tête du nœud."
translations["Tutorial_Data_Node_2"] = "Cliquez et faites glisser les connecteurs pour connecter les nœuds afin d'envoyer des données entre eux. Pour les supprimer, faites un clic gauche pour sélectionner, puis un clic droit pour annuler."
translations["Tutorial_Output_Node_Info"] = "Les nœuds de sortie sont également là où vous devez envoyer des données. Il peut y avoir plus d'un nœud de sortie dont les conditions doivent être remplies. Certains nœuds de sortie doivent recevoir des données dans le bon ordre."
translations["Tutorial_Output_Node_2"] = translations["Node_Output"]
translations["Tutorial_Data_Node"] = translations["Node_Data"]
translations["Tutorial_If_Else_Node"] = translations["Node_If_Else"]
translations["Tutorial_Alternate_Node"] = translations["Node_Alternate"]
translations["Tutorial_Limit_Node"] = translations["Node_Limit"]
translations["Tutorial_Halt_Node"] = translations["Node_Halt"]
translations["Tutorial_Ordered_Node"] = translations["Node_Ordered_Output"]
translations["Tutorial_Output_Node"] = translations["Node_Output"]
translations["Tutorial_View_Node"] = translations["Node_View"]
translations["Tutorial_Reroute_Node"] = translations["Node_Reroute"]
translations["Tutorial_Main_Menu_Button"] = "Menu principal"
translations["Tutorial_Puzzle_Name"] = "Didacticiel"
translations["Tutorial_Run_Button"] = "Courir"
translations["Tutorial_Show_Nodes_Button"] = "Afficher les nœuds"
translations["Tutorial_Hide_Nodes_Button"] = "Masquer les nœuds"
translations["Tutorial_Save_Button"] = "Sauvegarder le jeu"
translations["Tutorial_Center_Button"] = "Centre"
translations["Tutorial_Clear_Button"] = "Dégager"

translations["Header_Main_Menu"] = "Menu principal"
translations["Header_Run_Program"] = "Courir"
translations["Header_Edit_Program"] = "Éditer"
translations["Header_Show_Nodes"] = "Afficher les nœuds"
translations["Header_Hide_Nodes"] = "Masquer les nœuds"
translations["Header_Save"] = "Sauvegarder le jeu"
translations["Header_Center"] = "Centre"
translations["Header_Clear"] = "Dégager"

translations["Saving"] = "..."

translations["Header_Logic"] = "Logique"
translations["Header_Math"] = "Mathématiques"
translations["Header_Puzzle"] = "Puzzle"

translations["Show_Error_Log"] = "Afficher le journal"
translations["Hide_Error_Log"] = "Masquer le journal"
translations["Clear_Log"] = "Dégager"
translations["Disable_Scroll"] = "Désactiver le défilement"
translations["Enable_Scroll"] = "Activer le défilement"
translations["View_IDs"] = "Afficher les ID de nœud"
translations["Hide_IDs"] = "Masquer les ID de nœud"
translations["Skip_Song"] = "Sauter la chanson"

translations["Log_Graph_Cleared"] = "Écran de nœud effacé"
translations["Log_Changed_Song"] = "Chanson changée en"

translations["Well_Done"] = "Bien fait!"
translations["Well_Done_Complete"] = "Bravo, tous les puzzles sont terminés"
translations["Puzzle_Score"] = "Score d'énigme"
translations["Try_Again"] = "Réessayer"
translations["Result_Title"] = "Bien fait!"
translations["Result_Edit"] = "Éditer"
translations["Result_Next"] = "Prochaine"

translations["Info_Data"] = "Ce nœud contient les données du puzzle qui doivent être transférées vers les nœuds de sortie.\n\nLes données peuvent être différentes choses, dans le cas de ce nœud, la forme est une chaîne et la quantité est un nombre (entier). Le nœud de données envoie la chaîne et le numéro sur demande."
translations["Info_Alternate"] = "Ce nœud basculera entre la connexion supérieure et inférieure sur chaque donnée reçue. Considérez cela comme un interrupteur marche/arrêt. Lorsqu'il est activé, les données passeront par le haut, lorsqu'il est désactivé, les données passeront par le bas.\n\nCeci est utile lorsque vous devez diviser le même type de données afin qu'il aille dans 2 entrées différentes."
translations["Info_Halt"] = "Ce nœud joue un rôle important en s'assurant que les données sont envoyées à la sortie dans le bon ordre. Chaque nœud d'arrêt se verra attribuer un numéro de commande en fonction de l'ordre dans lequel vous le connectez au nœud de sortie.\n\nIl est important de se rappeler que les nœuds d'arrêt doivent être directement connectés aux nœuds de sortie, sinon votre programme échouera. Cela n'a aucun sens d'arrêter les données au début de votre programme, vous devez traiter les données puis définir l'ordre à la fin pour améliorer les performances."
translations["Info_If_Else"] = "Ce nœud exécutera les instructions du bloc if si l'expression est vraie. Si l'expression est fausse, les instructions du bloc else seront exécutées."
translations["Info_View"] = "Ce nœud est utilisé pour déboguer la sortie des autres nœuds. Ce nœud n'affecte pas le score du puzzle."
translations["Info_Absolute"] = "Ce nœud renverra la valeur absolue d'un nombre.\n\nDonc, si le nombre est négatif, ce nœud le renverra sous forme de nombre positif. Si le nombre est zéro ou positif, aucun changement n'aura lieu."
translations["Info_Add"] = "Ce nœud ajoutera les données d'entrée supérieure et inférieure ensemble. Ce nœud fonctionne avec des nombres positifs et négatifs."
translations["Info_Divide"] = "Ce nœud divisera les données d'entrée supérieures par les données inférieures et les sortira."
translations["Info_Greater_Than"] = "Ce nœud vérifie les données d'entrée pour voir si elles sont supérieures à l'ensemble de conditions. S'il est supérieur, les données seront envoyées à la connexion supérieure, sinon à la connexion inférieure. Ceci est très similaire à un nœud if else.\n\nAstuce : Vous pouvez maintenir la touche Maj enfoncée tout en cliquant pour incrémenter de 5."
translations["Info_Multiply"] = "Ce nœud multipliera les données d'entrée supérieures avec les données d'entrée inférieures. Ce nœud fonctionne avec des nombres positifs et négatifs."
translations["Info_Subtract"] = "Ce nœud soustraira les données d'entrée inférieures des données d'entrée supérieures. Cela fonctionne avec des nombres positifs et négatifs."
translations["Info_View"] = "Ce nœud est utilisé pour déboguer la sortie des autres nœuds. Ce nœud n'affecte pas le score du puzzle."
translations["Info_Output"] = "Ce nœud est également le dernier endroit où les données sont envoyées. Les données envoyées à ce nœud doivent remplir les conditions définies. Si une condition échoue, l'ensemble du programme échouera."
translations["Info_Ordered_Output"] = "Ce nœud nécessite que les données soient reçues dans un ordre spécifique et remplissent les conditions.\n\nUtilisez Halt Nodes pour ordonner les données. Lors de la connexion d'un nœud d'arrêt, il recevra un ordre basé sur le nombre de nœuds d'arrêt actuellement connectés à ce nœud."
translations["Info_Limit"] = "Ce nœud se comporte de manière très similaire à un nœud If Else. La seule différence est que ce nœud utilise un compteur dans la condition if pour agir comme notre valeur de vérité. Une fois que ce compteur atteint 0, les instructions du bloc else seront exécutées."
translations["Info_View_Example"] = "Voir l'exemple"

translations["Error_No_Output_Connection_Where_To"] = "Pas de connexion de sortie. Les données doivent aller quelque part."
translations["Error_No_Falsy_Output"] = "Pas de fausse connexion de sortie."
translations["Error_No_Truthy_Falsy_Output"] = "Pas de connexions de sortie vraies ou fausses."
translations["Error_No_Alternate_Output"] = "Pas de connexions de sortie à alterner."
translations["Error_No_Alternate_Top_Output"] = "Pas de connexion de sortie supérieure pour alterner."
translations["Error_No_Alternate_Bottom_Output"] = "Pas de connexion de sortie inférieure pour alterner."
translations["Error_No_Bottom_Output"] = "Pas de connexion de sortie inférieure."
translations["Error_No_Output_Connections"] = "Pas de connexions de sortie."
translations["Error_Input_Data_Not_Match_Stored"] = "Les données d'entrée ne correspondent pas aux données stockées."
translations["Error_No_Output_Connection"] = "Pas de connexion de sortie."
translations["Error_Not_Ordered_Output_Node"] = "Connecté au nœud n'est pas un nœud de sortie ordonné. Connexion directe requise."
translations["Error_Exceeded_square"] = "Les données (carré) ont dépassé la quantité requise."
translations["Error_Exceeded_circle"] = "Les données (cercle) ont dépassé le montant requis."
translations["Error_Exceeded_plus"] = "Les données (Plus) ont dépassé le montant requis."
translations["Error_Exceeded_triangle"] = "Les données (Triangle) ont dépassé la quantité requise."
translations["Error_No_Match"] = "Les données d'entrée ne correspondent pas aux données requises."
translations["Error_Wrong_Order"] = "Les données d'entrée ne sont pas dans le bon ordre."

translations["Graph_Reset_Center"] = "Graphique remis au centre."
translations["Total_Nodes"] = "Nombre total de nœuds"
translations["Total_Reroute_Nodes"] = "Total des nœuds de réacheminement"
translations["Total_View_Nodes"] = "Nombre total de nœuds d'affichage"
translations["Game_Saved"] = "Jeu enregistré."

return translations
local translations = {}

-- translations[""] = ""

translations["Node_Data"] = "Data"
translations["Node_Output"] = "Output"
translations["Node_Ordered_Output"] = "Ordered Output"
translations["Node_If_Else"] = "If Else"
translations["Node_Alternate"] = "Alternate"
translations["Node_Limit"] = "Limit"
translations["Node_Halt"] = "Halt"
translations["Node_Greater_Than"] = "Greater Than"
translations["Node_Absolute"] = "Absolute"
translations["Node_Add"] = "Add"
translations["Node_Multiply"] = "Multiply"
translations["Node_Subtract"] = "Subtract"
translations["Node_Reroute"] = "Reroute"
translations["Node_View"] = "View"

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

translations["Square"] = "Square"
translations["Circle"] = "Circle"
translations["Plus"] = "Plus"
translations["Triangle"] = "Triangle"

translations["Logic_Puzzles_Button"] = "LOGIC PUZZLES"
translations["Math_Puzzles_Button"] = "MATH PUZZLES"
translations["Tutorial_Button"] = "TUTORIAL"
translations["Glossary_Button"] = "NODE GLOSSARY"
translations["Donate_Button"] = "GIVE A TIP"
translations["Settings_Button"] = "SETTINGS"
translations["Play_Logic"] = "PLAY"
translations["Select_Logic"] = "SELECT"
translations["Play_Math"] = "PLAY"
translations["Select_Math"] = "SELECT"

translations["Donate_Title"] = "GIVE A TIP"
translations["Donate_Body"] = "Giving tips is completely optional and does not effect the gameplay in anyway. All tips are very much appreciated."

translations["Logic_List_Title"] = "LOGIC PUZZLE LIST"
translations["Math_List_Title"] = "MATH PUZZLE LIST"

translations["Glossary_Title"] = "NODE GLOSSARY"
translations["Glossary_Logic_Nodes"] = "LOGIC"
translations["Glossary_Data_Node_Title"] = "DATA"
translations["Glossary_Data_Node_Desc"] = "The Data Node holds the data for the puzzle.It can have multiple data types. The output order is not guaranteed."
translations["Glossary_Output_Node_Title"] = "OUTPUT"
translations["Glossary_Output_Node_Desc"] = "The output node is where data is sent too. Some output nodes can require more than one data type, and must meet the required amount."
translations["Glossary_Ordered_Output_Node_Title"] = "ORDERED OUTPUT"
translations["Glossary_Ordered_Output_Node_Desc"] = "Acts like the Output Node, but the order of the data must be met. The number above the symbol is the order it must be received in. Used with Halt Nodes."
translations["Glossary_If_Else_Node_Title"] = "IF ELSE"
translations["Glossary_If_Else_Node_Desc"] = "The If Else Node allows you to compare the input against the selected value from the drop down. If the condition is true, the data will be sent to the top. Otherwise, it will be sent to the bottom."
translations["Node_If_Else_Else"] = "Else"
translations["Node_If_Else_Square"] = "Square"
translations["Glossary_Alternate_Node_Title"] = "ALTERNATE"
translations["Glossary_Alternate_Node_Desc"] = "The Alternate Node will alternate the incoming data between the top and bottom outputs."
translations["Glossary_Limit_Node_Title"] = "LIMIT"
translations["Glossary_Limit_Node_Desc"] = "The Limit Node will limit the incoming data going through the top output based on the limit count set. Once the limit count has been reached, the incoming data will be sent to the bottom output."
translations["Glossary_Halt_Node_Title"] = "HALT"
translations["Glossary_Halt_Node_Desc"] = "The Halt Node will halt data being sent to the Output Node. This is the only node that needs to be directly connected to an Output Node. The number top left of the node, indicates the order. This is useful when more than 1 Halt Node is connected."

translations["Glossary_Math_Nodes"] = "MATH"
translations["Glossary_Math_Data_Node_Title"] = "DATA"
translations["Glossary_Math_Data_Node_Desc"] = "The data node holds the data for the puzzle. It can have multiple numbers. The output order is not guaranteed."
translations["Glossary_Math_Output_Node_Title"] = "OUTPUT"
translations["Glossary_Math_Output_Node_Desc"] = "The Output Node is where data is sent too. Some output nodes can require more than one number, and must meet the required amount."
translations["Glossary_Math_Alternate_Node_Title"] = "ALTERNATE"
translations["Glossary_Math_Alternate_Node_Desc"] = "The Alternate Node will alternate the incoming number data between the top and bottom outputs."
translations["Glossary_Math_Greater_Than_Node_Title"] = "GREATER THAN"
translations["Glossary_Math_Greater_Than_Node_Desc"] = "The Greater Than Node checks the incoming number data against the value set. If the data is greater, then it will be sent out of the top output, otherwise the bottom. Holding Shift while adjusting the value will go up or down by 5."
translations["Glossary_Math_Absolute_Node_Title"] = "ABSOLUTE"
translations["Glossary_Math_Absolute_Node_Desc"] = "The Absolute Node will output the absolute value of the number data. For example, -25 will become 25."
translations["Glossary_Math_Add_Node_Title"] = "ADD"
translations["Glossary_Math_Add_Node_Desc"] = "The Add Node will add the number data incoming top and bottom, and output the number data added together. This supports negative numbers."
translations["Glossary_Math_Multiply_Node_Title"] = "MULTIPLY"
translations["Glossary_Math_Multiply_Node_Desc"] = "The Multiply Node will multiply the top and bottom incoming number data, and output it multiplied. This supports negative numbers."
translations["Glossary_Math_Subtract_Node_Title"] = "SUBTRACT"
translations["Glossary_Math_Subtract_Node_Desc"] = "The Subtract Node will take away the bottom number data from the top number data, and output it. This supports negative numbers."

translations["Glossary_Misc_Nodes"] = "OTHER"
translations["Glossary_Misc_Reroute_Node_Title"] = "REROUTE"
translations["Glossary_Misc_Reroute_Node_Desc"] = "The Reroute node allows you to tidy up your graph by rerouting the connector wires. This node do not effect the puzzle score."
translations["Glossary_Misc_View_Node_Title"] = "VIEW"
translations["Glossary_Misc_View_Node_Desc"] = "The View Node helps you debug your program by see what the output is of another node. This node interrupts the program, meaning it won't complete, so should be disconnected when finished. This node does not effect the puzzle score."

translations["Settings_Title"] = "Settings"
translations["Sound_Effects_Volume"] = "Sound Effects Volume"
translations["Music_Volume"] = "Music Volume"
translations["Select_Language"] = "Language"
translations["Save_Button"] = "Save Settings"
translations["Close_Button"] = "Close Settings"

translations["Puzzle"] = "Puzzle"
translations["PUZZLE"] = "PUZZLE"
translations["Score"] = "Score"

translations["Tutorial_Exit"] = "Exit"
translations["Tutorial_Next"] = "Next"
translations["Tutorial_Welcome_Title"] = "TUTORIAL"
translations["Tutorial_Welcome_Msg"] = "This tutorial will cover the very basics of the UI. It will explain the top header controls as well as explain the very basics of the nodes.\n\nIf you are unsure how a node works, check the Node Glossary at the main menu which explains all nodes in detail."
translations["Tutorial_Main_Menu"] = "Takes you back to the main menu."
translations["Tutorial_Awards"] = "Current award which updates when the program is running."
translations["Tutorial_Speed"] = "Controls the speed of the program. Slowing down the program speed is useful when you need to debug data transfer."
translations["Tutorial_Run"] = "Run or Edit your program. When your program is running, nodes can not be edited."
translations["Tutorial_Show_Nodes"] = "Show or Hide nodes for the current puzzle. As you progress, more nodes will be available to use."
translations["Tutorial_Save"] = "Allows you to save the current puzzle progress. Only 1 puzzle progress can be saved. Autosaving is enabled."
translations["Tutorial_Center"] = "Centers the graph (Shortcut F)."
translations["Tutorial_Clear"] = "Clears all nodes on the node graph."
translations["Tutorial_Nodes"] = "Nodes available for the puzzle will show up here. Clicking on the node will add it to the center of the graph."
translations["Tutorial_Data_Node_Dummy"] = "Data"
translations["Tutorial_Data_Node_Info"] = "Data Nodes hold the data that needs to be sent to Output Nodes. You can drag these nodes around by clicking and holding down the left mouse button on the node header."
translations["Tutorial_Data_Node_2"] = "Click and drag the connectors to connect up nodes so send data between them.  To remove them, left click to select, then right click to cancel."
translations["Tutorial_Output_Node_Info"] = "Output Nodes are where you need to send data too.  There can be more than 1 Output Node that need to have its conditions met.  Some Output Nodes need to receive data in the correct order."
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
translations["Tutorial_Main_Menu_Button"] = "Main Menu"
translations["Tutorial_Puzzle_Name"] = "Tutorial"
translations["Tutorial_Run_Button"] = "Run"
translations["Tutorial_Show_Nodes_Button"] = "Show Nodes"
translations["Tutorial_Hide_Nodes_Button"] = "Hide Nodes"
translations["Tutorial_Save_Button"] = "Save Game"
translations["Tutorial_Center_Button"] = "Center"
translations["Tutorial_Clear_Button"] = "Clear"

translations["Header_Main_Menu"] = "Main Menu"
translations["Header_Run_Program"] = "Run"
translations["Header_Edit_Program"] = "Edit"
translations["Header_Show_Nodes"] = "Show Nodes"
translations["Header_Hide_Nodes"] = "Hide Nodes"
translations["Header_Save"] = "Save Game"
translations["Header_Center"] = "Center"
translations["Header_Clear"] = "Clear"

translations["Saving"] = "Saving..."

translations["Header_Logic"] = "Logic"
translations["Header_Math"] = "Math"
translations["Header_Puzzle"] = "Puzzle"

translations["Show_Error_Log"] = "View Log"
translations["Hide_Error_Log"] = "Hide Log"
translations["Clear_Log"] = "Clear"
translations["Disable_Scroll"] = "Disable Scrolling"
translations["Enable_Scroll"] = "Enable Scrolling"
translations["View_IDs"] = "Show Node IDs"
translations["Hide_IDs"] = "Hide Node IDs"
translations["Skip_Song"] = "Skip Song"

translations["Log_Graph_Cleared"] = "Node graph cleared."
translations["Log_Changed_Song"] = "Changed song to"

translations["Well_Done"] = "Well Done!"
translations["Well_Done_Complete"] = "Well Done, All Puzzles Complete"
translations["Puzzle_Score"] = "Puzzle Score"
translations["Try_Again"] = "Try Again"
translations["Result_Title"] = "Well Done!"
translations["Result_Edit"] = "Edit"
translations["Result_Next"] = "Next"

translations["Info_Data"] = "This node holds the data for the puzzle that needs to be transferred to the output nodes.\n\nData can be different things, in the case of this node, the shape is a String and the quantity is a Number (Integer).  The Data node sends the string and number out when requested."
translations["Info_Alternate"] = "This node will switch between the top and bottom connection on each data received.  Think of this as an On and Off switch.  When it is On, the data will go through the top, when it is Off the data will go through the bottom.\n\nThis is useful when you need to split up the same data type so that it goes into 2 different inputs."
translations["Info_Halt"] = "This node plays an important role in making sure that the data is sent to the output in the correct order.  Each Halt node will be assigned an order number based on the order you connect it to the Output Node.\n\nIt is important to remember that Halt Nodes must be directly connected to Output Nodes, otherwise your program will fail.  It makes no sense halting data early in your program, you should process data then set the order at the end to improve performance."
translations["Info_If_Else"] = "This node will execute the if block statements if the expression is true.  If the expression is false then the statements in the else block will be executed."
translations["Info_View"] = "This node is used for debugging the output of other nodes. This node does not effect the puzzle score."
translations["Info_Absolute"] = "This node will return the absolute value of a number.\n\nSo if the number is negative, then this node will return it as a positive number.  If the number is zero, or positive, then no change will take place."
translations["Info_Add"] = "This node will add the top and bottom input data together. This node works with positive and negative numbers."
translations["Info_Divide"] = "This node will divide the top by the bottom input data, and output it."
translations["Info_Greater_Than"] = "This node checks the input data to see if it's greater than the condition set.  If it's greater, then the data will be sent to the top connection, otherwise the bottom.  This is very similar to an if else node.\n\nTip:  You can hold Shift while clicking to increment by 5."
translations["Info_Multiply"] = "This node will multiple the top input data with the bottom input data. This node works with positive and negative numbers."
translations["Info_Subtract"] = "This node will substact the bottom input data away from the top input data. This works with positive and negative numbers."
translations["Info_View"] = "This node is used for debugging the output of other nodes. This node does not effect the puzzle score."
translations["Info_Output"] = "This node is the final place the data is sent too.  Data sent to this node must meet the conditions set.  If any condition fails, then the whole program will fail to complete."
translations["Info_Ordered_Output"] = "This node requires data to be received in a specific order and meet the conditions.\n\nUse Halt Nodes to order the data.  When connecting a Halt Node, it will receive an order based on how many Halt Nodes are currently connected to this node."
translations["Info_Limit"] = "This node behaves very similar to a If Else node.  The only difference is this node uses a counter in the if condition to act as our truthy value.  Once that counter hits 0, the else block statements will be executed."
translations["Info_View_Example"] = "View Example"

translations["Error_No_Output_Connection_Where_To"] = "No output connection. The data needs to go somewhere."
translations["Error_No_Falsy_Output"] = "No false output connection."
translations["Error_No_Truthy_Falsy_Output"] = "No truth or false output connections."
translations["Error_No_Alternate_Output"] = "No output connections to alternate."
translations["Error_No_Alternate_Top_Output"] = "No top output connection to alternate."
translations["Error_No_Alternate_Bottom_Output"] = "No bottom output connection to alternate."
translations["Error_No_Bottom_Output"] = "No bottom output connection."
translations["Error_No_Output_Connections"] = "No output connections."
translations["Error_Input_Data_Not_Match_Stored"] = "Input data does not match stored data."
translations["Error_No_Output_Connection"] = "No output connection."
translations["Error_Not_Ordered_Output_Node"] = "Connected to node is not an Ordered Output Node. Direct connection required."
translations["Error_Exceeded_square"] = "Data (Square) has exceeded required amount."
translations["Error_Exceeded_circle"] = "Data (Circle) has exceeded required amount."
translations["Error_Exceeded_plus"] = "Data (Plus) has exceeded required amount."
translations["Error_Exceeded_triangle"] = "Data (Triangle) has exceeded required amount."
translations["Error_No_Match"] = "Input data does not match required data."
translations["Error_Wrong_Order"] = "Input data is not in the correct order."

translations["Graph_Reset_Center"] = "Graph reset to center."
translations["Total_Nodes"] = "Total Nodes"
translations["Total_Reroute_Nodes"] = "Total Reroute Nodes"
translations["Total_View_Nodes"] = "Total View Nodes"
translations["Game_Saved"] = "Game saved"

local str = ""

for k, v in pairs(translations) do
	str = str .. "\n" .. k .. "@" .. v:gsub("\n", "{n}")
end

print(str)
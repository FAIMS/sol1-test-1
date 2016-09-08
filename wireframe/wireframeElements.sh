#!/bin/bash

./makeElement.sh style_orientation_orientation "horizontal" input 1 false false false false false .
./makeElement.sh style_even_layout_weight "1" input 1 false false false false false .
./makeElement.sh style_large_layout_weight "3" input 1 false false false false false .
./makeElement.sh User_User_Select_User "Select User" dropdown 1 false false false false false .
./makeElement.sh User_User_Make_Test_Record "Make Test Record" button 1 false false false false false .
./makeElement.sh Test_Test_ID "ID" input 1 false false true false false .
./makeElement.sh Test_Test_Re-Call_SaveTabGroup "Re-Call SaveTabGroup" button 1 false false false false false .
./makeElement.sh Test_Test_Trigger_Autosave "Trigger Autosave" button 1 false false false false false .

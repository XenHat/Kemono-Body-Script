float g_Config_MaximumOpacity = 1.00;
vector g_Config_BladeColor = <1, 1, 1>;
integer g_Config_EnsureMaskingMode = 1;
integer anim_count;
string g_internal_version_s = "0.5.8";
list names_assoc = [ "ankleL" ,  "ankleR" ,
                     "calfL" ,  "calfR" ,  "kneeL" ,  "kneeR" ,
                     "shinLL" ,  "shinLR" ,  "abs" ,  "armLL" ,
                     "armLR" ,  "armUL" ,  "armUR" ,  "belly" ,
                     "body" ,  "elbowL" ,  "elbowR" ,  "footL" ,
                     "footR" ,  "handL" ,  "handR" ,  "shinUL" ,
                     "shinUR" ,  "shoulderLL" ,  "shoulderUR" ,
                     "thighUR" ,  "wristL" ,
                     "wristR" ];
list faces_assoc = [5, 5, 4, 4, 1, 1, 4, 4, "6,7", 7, 2, 0, 6, "2,3", 0, 4, 5,
                    0, 0, -1, -1, 3, 3, 3, 4, 4, 3, 1];
list faceshumanmode = [1, 1, 2, 2, 5, 5, 2, 2];
integer s_KFTPelvisMeshes_size = 0;
integer g_CurrentFittedButState = 1;
integer g_CurrentFittedNipState = 1;
integer g_CurrentFittedNipAlpha = 0;
integer g_CurrentFittedVagState = 1;
integer g_PreviousFittedNipState = 1;
integer g_HasAnimPerms = FALSE;
integer g_RuntimeBodyStateSettings;
integer human_mode = TRUE;
key g_Owner_k;
key g_Last_k;
list g_LinkDB_l = [];
list g_AttmntAuthedKeys_l;
string g_LastCommand_s;
string g_AnimDeform;
string g_AnimUndeform;
list xlGetFacesByBladeName(string name)
{
  if(name ==  "abs") {
    return [6, 7];
  }

  if(name ==  "ankleL") {
    if(human_mode) {
      return [1];
    }

    return [5];
  }

  if(name ==  "ankleR") {
    if(human_mode) {
      return [1];
    }

    return [5];
  }

  if(name ==  "armLL") {
    return [7];
  }

  if(name ==  "armLR") {
    return [2];
  }

  if(name ==  "armUL") {
    return [0];
  }

  if(name ==  "armUR") {
    return [6];
  }

  if(name ==  "belly") {
    return [2, 3];
  }

  if(name ==  "body") {
    return [0];
  }

  if(name ==  "breast") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [2, 3];
    }

    return [2, 5];
  }

  if(name ==  "calfL") {
    if(human_mode) {
      return [4];
    }

    return [2];
  }

  if(name ==  "calfR") {
    if(human_mode) {
      return [4];
    }

    return [2];
  }

  if(name ==  "chest") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [0, 1];
    }

    return [0, 4];
  }

  if(name ==  "collar") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [6, 7];
    }

    return [1, 6];
  }

  if(name ==  "elbowL") {
    return [4];
  }

  if(name ==  "elbowR") {
    return [5];
  }

  if(name ==  "footL") {
    return [0];
  }

  if(name ==  "footR") {
    return [0];
  }

  if(name ==  "hipL") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [5];
    }

    return [6];
  }

  if(name ==  "hipR") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [4];
    }

    return [5];
  }

  if(name ==  "kneeL") {
    if(human_mode) {
      return [5];
    }

    return [1];
  }

  if(name ==  "kneeR") {
    if(human_mode) {
      return [5];
    }

    return [1];
  }

  if(name ==  "handL") {
    return [-1];
  }

  if(name ==  "handR") {
    return [-1];
  }

  if(name ==  "neck") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [0, 1];
    }

    return [2, 5];
  }

  if(name ==  "nips") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [0, 1];
    }

    return [2, 3];
  }

  if(name ==  "pelvis") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [0, 1, 2, 3];
    }

    return [0, 1];
  }

  if(name ==  "ribs") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [4, 5];
    }

    return [1, 3];
  }

  if(name ==  "shinLL") {
    if(human_mode) {
      return [2];
    }

    return [4];
  }

  if(name ==  "shinLR") {
    if(human_mode) {
      return [2];
    }

    return [4];
  }

  if(name ==  "shinUL") {
    return [3];
  }

  if(name ==  "shinUR") {
    return [3];
  }

  if(name ==  "shoulderLL") {
    return [3];
  }

  if(name ==  "shoulderLR") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [2];
    }

    return [0];
  }

  if(name ==  "shoulderUL") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [5];
    }

    return [7];
  }

  if(name ==  "shoulderUR") {
    return [4];
  }

  if(name ==  "thighLL") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode) {
        return [1];
      }

      return [7];
    }

    return [6];
  }

  if(name ==  "thighLR") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode) {
        return [0];
      }

      return [6];
    }

    return [6];
  }

  if(name ==  "thighUL") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [5];
    }

    return [7];
  }

  if(name ==  "thighUR") {
    return [4];
  }

  if(name ==  "vagoo") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [0, 1];
    }

    return [0, 1];
  }

  if(name ==  "butt") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [2, 3, 4, 5];
    }

    return [];
  }

  if(name ==  "wristL") {
    return [3];
  }

  if(name ==  "wristR") {
    return [1];
  }

  return [];
}
list xlBladeNameToPrimNames(string name)
{
  if(name ==  "armLL") {
    return [ "arms" ];

  } else if(name ==  "armLR") {
    return [ "arms" ];

  } else if(name ==  "armUL") {
    return [ "arms" ];

  } else if(name ==  "armUR") {
    return [ "arms" ];

  } else if(name ==  "elbowL") {
    return [ "arms" ];

  } else if(name ==  "elbowR") {
    return [ "arms" ];

  } else if(name ==  "wristL") {
    return [ "arms" ];

  } else if(name ==  "wristR") {
    return [ "arms" ];

  } else if(name ==  "ribs") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoChest" ];
    }

    return [ "body" ];

  } else if(name ==  "abs") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoChest" ];
    }

    return [ "body" ];

  } else if(name ==  "body") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoChest" ];
    }

    return [ "body" ];

  } else if(name ==  "breast") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoChest" ];
    }

    return [ "body" ];

  } else if(name ==  "chest") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoChest" ];
    }

    return [ "body" ];

  } else if(name ==  "collar") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "Fitted Kemono Torso" ];
    }

    return [ "neck" ];

  } else if(name ==  "handL") {
    return [ "handL" ];

  } else if(name ==  "handR") {
    return [ "handR" ];

  } else if(name ==  "hipL"  || name ==  "hipR") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [llList2String(["BitState0", "BitState1", "BitState2", "BitState3"] ,
                            g_CurrentFittedVagState)];
    }

    return [ "hips" ];

  } else if(name ==  "neck") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "Fitted Kemono Torso" ];
    }

    return [ "neck" ];

  } else if(name ==  "pelvis") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [llList2String(["BitState0", "BitState1", "BitState2", "BitState3"] ,
                            g_CurrentFittedVagState)];
    }

    return [ "hips" ];

  } else if(name ==  "kneeR") {
    if(human_mode) {
      return [ "RHleg" ];
    }

    return [ "RFleg" ];

  } else if(name ==  "footR") {
    if(human_mode) {
      return [ "RHleg" ];
    }

    return [ "RFleg" ];

  } else if(name ==  "ankleR") {
    if(human_mode) {
      return [ "RHleg" ];
    }

    return [ "RFleg" ];

  } else if(name ==  "shinUR") {
    if(human_mode) {
      return [ "RHleg" ];
    }

    return [ "RFleg" ];

  } else if(name ==  "calfR") {
    if(human_mode) {
      return [ "RHleg" ];
    }

    return [ "RFleg" ];

  } else if(name ==  "shinLR") {
    if(human_mode) {
      return [ "RHleg" ];
    }

    return [ "RFleg" ];

  } else if(name ==  "calfL") {
    if(human_mode) {
      return [ "LHleg" ];
    }

    return [ "LFleg" ];

  } else if(name ==  "ankleL") {
    if(human_mode) {
      return [ "LHleg" ];
    }

    return [ "LFleg" ];

  } else if(name ==  "footL") {
    if(human_mode) {
      return [ "LHleg" ];
    }

    return [ "LFleg" ];

  } else if(name ==  "kneeL") {
    if(human_mode) {
      return [ "LHleg" ];
    }

    return [ "LFleg" ];

  } else if(name ==  "shinLL") {
    if(human_mode) {
      return [ "LHleg" ];
    }

    return [ "LFleg" ];

  } else if(name ==  "shinUL") {
    if(human_mode) {
      return [ "LHleg" ];
    }

    return [ "LFleg" ];

  } else if(name ==  "shoulderLL") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "Fitted Kemono Torso" ];
    }

    return [ "neck" ];

  } else if(name ==  "shoulderLR") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "Fitted Kemono Torso" ];
    }

    return [ "neck" ];

  } else if(name ==  "shoulderUL") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "Fitted Kemono Torso" ];
    }

    return [ "neck" ];

  } else if(name ==  "shoulderUR") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "Fitted Kemono Torso" ];
    }

    return [ "neck" ];

  } else if(name ==  "thighUL") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoEtc" ];
    }

    return [ "hips" ];

  } else if(name ==  "thighUR") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoEtc" ];
    }

    return [ "hips" ];

  } else if(name ==  "belly") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "TorsoEtc" ];
    }

    return [ "hips" ];

  } else if(name ==  "nips") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(1 == g_CurrentFittedNipAlpha) {
        return [ "NipAlpha" ];

      } else if(2 == g_CurrentFittedNipAlpha) {
        return [ "NipState0" ];

      } else {
        return [llList2String([ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] ,
                              g_CurrentFittedNipState)];
      }
    }

    return [ "PG" ];

  } else if(name ==  "NipAlpha") {
    if(g_RuntimeBodyStateSettings & 1) {
      return [ "NipAlpha" ];
    }

    return [ "PG" ];

  } else if(name ==  "vagoo") {
    return [ "PG" ];

  } else if(name ==  "thighLR") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode) {
        return [ "HumanLegs" ];
      }

      return [ "TorsoEtc" ];
    }

    if(human_mode) {
      return [ "RHleg" ];
    }

    return [ "RFleg" ];

  } else if(name ==  "thighLL") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode) {
        return [ "HumanLegs" ];
      }

      return [ "TorsoEtc" ];
    }

    if(human_mode) {
      return [ "LHleg" ];
    }

    return [ "LFleg" ];
  }

  return [name];
}
xlProcessCommandWrapper()
{
  if(g_LastCommand_s ==
      "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR") {
    reset();

  } else if(g_LastCommand_s == "resetA") {
    reset();

  } else if(g_LastCommand_s == "resetB") {
    g_AttmntAuthedKeys_l = [];
    reset();

  } else if(g_LastCommand_s == "Hlegs") {
    human_mode = FALSE;
    g_LastCommand_s =
      "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
    human_mode = TRUE;
    g_LastCommand_s =
      "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
    llSetObjectDesc(g_internal_version_s + "*" + (string)human_mode + "*" +
                    (string)g_Config_BladeColor) ;

  } else if(g_LastCommand_s == "Flegs") {
    human_mode = TRUE;
    g_LastCommand_s =
      "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
    human_mode = FALSE;
    g_LastCommand_s =
      "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
    llSetObjectDesc(g_internal_version_s + "*" + (string)human_mode + "*" +
                    (string)g_Config_BladeColor) ;

  } else if(g_LastCommand_s == "Rhand:1") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-R-relax");
      } ;
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-point");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:2") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-R-hold");
      } ;
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-point");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:3") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-R-fist");
      } ;
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-point");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:4") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-R-point");
      } ;
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:5") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-R-horns");
      } ;
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-point");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:1") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-L-relax");
      } ;
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-point");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:2") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-L-hold");
      } ;
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-point");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:3") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-L-fist");
      } ;
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-point");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:4") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-L-point");
      } ;
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:5") {
    if(g_HasAnimPerms) {
      {
        llStartAnimation("Kem-hand-L-horns");
      } ;
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-point");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if("reqFTdat" == g_LastCommand_s) {
    if(g_RuntimeBodyStateSettings & 1) {
      llRegionSayTo(g_Owner_k,  -34525475 , "resFTdat:nipState:"
                    + (string)g_CurrentFittedNipState
                    + ":nipAlpha:" + (string)g_CurrentFittedNipAlpha
                    + ":nipOvrd:0"
                    + ":vagState:" + (string)g_CurrentFittedVagState
                    + ":buttState:" + (string)g_CurrentFittedButState
                    + ":humLegs:" + (string)human_mode);
    }

    return;

  } else {
    if(llSubStringIndex(g_LastCommand_s, "resCLdat") == 0) {
      if(g_RuntimeBodyStateSettings & 1) {
        list data = llParseString2List(g_LastCommand_s, [":"], []);
        string clothDesc = llList2String(data, 4);
        integer clothState = llList2Integer(data, 8);

        if("Top" == clothDesc) {
          if(0 == clothState) {
          } else {
            g_PreviousFittedNipState = g_CurrentFittedNipState;
          }
        }
      }

      return;
    }

    xlProcessCommand(TRUE);
  }
}
xlProcessCommand(integer send_params)
{
  list input_data = llParseString2List(g_LastCommand_s, [":"], []);
  string command = llList2String(input_data, 0);
  integer list_size = llGetListLength(input_data);
  integer index = 0;
  integer i_make_visible = -1;
  list local_params;
  integer mesh_count_index = 0;
  integer mod_command = -1;
  integer mod_command_2 = -1;

  for(; index < list_size ; index++) {
    command = llList2String(input_data, index);

    if(0 == index) {
      if("setnip" == command) {
        {
          mesh_count_index = ((llGetListLength([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                                 "NipAlpha" ])) - 1) ;
          mod_command =  268435455 ;
          mod_command_2 =  4 ;
        }

      } else if("nipalpha" == command) {
        mesh_count_index = ((llGetListLength([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                               "NipAlpha" ])) - 1) ;
        mod_command =  1073741824 ;
        mod_command_2 =  4 ;

      } else if("setbutt" == command) {
        mesh_count_index = s_KFTPelvisMeshes_size;
        mod_command =  134217727 ;
        mod_command_2 =  4 ;

      } else if("setvag" == command) {
        mesh_count_index = s_KFTPelvisMeshes_size;
        mod_command_2 =  4 ;
        mod_command =  536870911 ;
        integer st = llList2Integer(input_data, 1);
        llSetLinkPrimitiveParamsFast(LINK_ROOT, [
                                       PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                           llListFindList(g_LinkDB_l, ["BitState3"]) + 1), PRIM_COLOR, -1,
                                       g_Config_BladeColor, st == 3 * g_Config_MaximumOpacity
                                       , PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                           llListFindList(g_LinkDB_l, ["BitState2"]) + 1), PRIM_COLOR, -1,
                                       g_Config_BladeColor, st == 2 * g_Config_MaximumOpacity
                                       , PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                           llListFindList(g_LinkDB_l, ["BitState1"]) + 1), PRIM_COLOR, -1,
                                       g_Config_BladeColor, st == 1 * g_Config_MaximumOpacity
                                       , PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                           llListFindList(g_LinkDB_l, ["BitState0"]) + 1), PRIM_COLOR, -1,
                                       g_Config_BladeColor, st == 0 * g_Config_MaximumOpacity]);

      } else if("show" == command) {
        i_make_visible = TRUE;

      } else if("hide" == command) {
        i_make_visible = FALSE;

      } else if("remove" == command) {
        integer placeinlist = llListFindList(g_AttmntAuthedKeys_l, [g_Last_k]);

        if(placeinlist != -1) {
          g_AttmntAuthedKeys_l = llDeleteSubList(g_AttmntAuthedKeys_l,
                                                 placeinlist, placeinlist);
        }

      } else if(llSubStringIndex(command, "color*<") != -1) {
        g_Config_BladeColor = (vector)llGetSubString(command, 6, -1);
      }

    } else {
      if(mod_command < 1) {
        if("nips"  == command) {
          g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings & (~ 4)) |
                                       (4 * !i_make_visible) ;

          if(g_RuntimeBodyStateSettings & 16) {
            return;
          }

          if(g_RuntimeBodyStateSettings & 1) {
            mod_command =  4 ;
            mod_command_2 =  4 ;

          } else {
            mod_command =  4 ;
            mod_command_2 =  2 ;
          }

        } else if("vagoo"  == command) {
          mod_command =  8 ;
          mod_command_2 =  2 ;
          g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings & (~ 8)) |
                                       (8 * !i_make_visible) ;

        } else {
          mod_command_2 =  2 ;
        }
      }

      if(4  == mod_command_2) {
        integer param = llList2Integer(input_data, index);
        string mesh_name = "";

        for(; mesh_count_index > -1; mesh_count_index--) {
          if(4  == mod_command) {
            g_LastCommand_s = "setnip:" + (string)i_make_visible;
            xlProcessCommand(TRUE);
          }

          if(1073741824  == mod_command) {
            g_CurrentFittedNipAlpha = param;
            mesh_name = llList2String([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                        "NipAlpha" ] , mesh_count_index);
            i_make_visible = (g_CurrentFittedNipAlpha == 1) * (mesh_count_index == 3);

            if(0 == param) {
              mod_command =  268435455 ;
              param = g_PreviousFittedNipState;

            } else {
              g_PreviousFittedNipState = g_CurrentFittedNipState;
            }
          }

          if(268435455  == mod_command) {
            g_CurrentFittedNipState = param;

            if(!g_CurrentFittedNipAlpha) {
              {
                i_make_visible =
                  (mesh_count_index == g_CurrentFittedNipState);
                mesh_name = llList2String([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                            "NipAlpha" ] , mesh_count_index);
              }
            }

          } else if(536870911  == mod_command) {
            g_CurrentFittedVagState = param;

          } else if(134217727  == mod_command) {
            g_CurrentFittedButState = param;
            i_make_visible =
              (mesh_count_index == param);
            mesh_name = llList2String(["BitState0", "BitState1", "BitState2", "BitState3"] ,
                                      mesh_count_index);
          }

          if(llStringLength(mesh_name) > 0) {
            list prim_names = xlBladeNameToPrimNames(mesh_name);
            integer link_id = llList2Integer(g_LinkDB_l,
                                             llListFindList(g_LinkDB_l, prim_names) + 1);
            local_params += [PRIM_LINK_TARGET, link_id];
            list faces_l = [];

            if(268435455  == mod_command ||  4  == mod_command) {
              faces_l = xlGetFacesByBladeName("nips");

            } else if(536870911  == mod_command) {
              faces_l = xlGetFacesByBladeName("vagoo");
              llOwnerSay("cccccc");

            } else if(1073741824  == mod_command) {
              faces_l = xlGetFacesByBladeName("nips");

            } else if(134217727  == mod_command) {
              faces_l = xlGetFacesByBladeName("butt");
            }

            integer faces_count = llGetListLength(faces_l);
            integer i2 = 0;

            for(; i2 < faces_count; i2++) {
              local_params += [PRIM_COLOR,
                               llList2Integer(faces_l, i2), g_Config_BladeColor,
                               i_make_visible * g_Config_MaximumOpacity
                              ];
            }
          }
        }

      } else if(2  == mod_command_2) {
        list prim_names = xlBladeNameToPrimNames(command);
        local_params += [
                          PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                              llListFindList(g_LinkDB_l, prim_names) + 1)
                        ];
        list faces_l = xlGetFacesByBladeName(command);
        integer faces_index = ((llGetListLength(faces_l)) - 1) ;

        for(; faces_index > -1; faces_index--) {
          local_params += [
                            PRIM_COLOR, llList2Integer(faces_l, faces_index), g_Config_BladeColor,
                            (i_make_visible) *
                            g_Config_MaximumOpacity
                          ];
        }

        if("breast"  == command) {
          if(g_RuntimeBodyStateSettings & 1) {
            g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings & (~ 16)) |
                                         (16 * !i_make_visible) ;
            list faces = xlGetFacesByBladeName("nips");
            list snd_lvl_params = [
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [ "NipState0" ]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 0
                                        || (g_RuntimeBodyStateSettings & 4)
                                       ),
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 0
                                        || (g_RuntimeBodyStateSettings & 4)
                                       ),
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [ "TorsoEtc" ]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 1
                                    && !(g_RuntimeBodyStateSettings & 4)
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 1
                                    && !(g_RuntimeBodyStateSettings & 4)
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [ "NipState1" ]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 2
                                    && !(g_RuntimeBodyStateSettings & 4)
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 2
                                    && !(g_RuntimeBodyStateSettings & 4)
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [ "NipAlpha" ]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible && g_CurrentFittedNipAlpha > 0
                                    && !(g_RuntimeBodyStateSettings & 4),
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible && g_CurrentFittedNipAlpha > 0
                                    && !(g_RuntimeBodyStateSettings & 4)
                                  ];
            local_params += snd_lvl_params;
          }
        }
      }
    }
  }

  if(send_params) {
    llSetLinkPrimitiveParamsFast(LINK_ROOT, local_params) ;
    local_params = [];
  }
}
resetHands()
{
  if(g_HasAnimPerms) {
    {
      llStartAnimation("Kem-hand-R-relax");
    } ;
    {
      llStartAnimation("Kem-hand-L-relax");
    } ;
    llStopAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-point");
    llStopAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-point");
    {
      llStartAnimation(g_AnimDeform);
    } ;
    llStopAnimation(g_AnimUndeform);
  }
}
reset()
{
  if(g_RuntimeBodyStateSettings & 1) {
    g_LastCommand_s = ":setnip:" + (string) 1  + ":setnip:" +
                      (string) 1 ;
    xlProcessCommand(TRUE);
  }

  g_LastCommand_s =
    "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR"
    ;
  xlProcessCommand(TRUE);
  resetHands();
}
detectLinkSetMods()
{
  g_LinkDB_l = [];
  integer part = llGetNumberOfPrims();
  integer found_fitted_torso = FALSE;

  for(; part > 0; --part) {
    string name = llGetLinkName(part);

    if(!found_fitted_torso) {
      if(name ==  "Fitted Torso Old Root") {
        found_fitted_torso = TRUE;
        name =  "Fitted Kemono Torso" ;

      } else if(llSubStringIndex(name, "Kemono") != -1 &&
                llSubStringIndex(name, "Torso") != -1 &&
                (llSubStringIndex(name, "Petite") != -1 ||
                 llSubStringIndex(name, "Busty") != -1)) {
        found_fitted_torso = TRUE;
        llSetLinkPrimitiveParams(part, [PRIM_NAME,  "Fitted Torso Old Root" ]);
        name =  "Fitted Kemono Torso" ;
      }
    }

    if(llListFindList(["BitState0", "BitState1", "BitState2", "BitState3",
                       "cumButtS1", "cumButtS2", "cumButtS3", "arms" , "body" , "Fitted Kemono Torso" ,
                       "TorsoChest" , "TorsoEtc" , "HumanLegs" , "NipState0" , "NipState1" ,
                       "NipAlpha" , "handL" , "handR" , "hips" , "LFleg" , "LHleg" , "RFleg" ,
                       "RHleg" , "neck" , "PG" , "Kemono - Body" , "Kemono Body" ] , [name]) != -1) {
      g_LinkDB_l += [name, part];
    }
  }

  if(found_fitted_torso) {
    g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings | 1) ;
    g_LastCommand_s = "setbutt:" + (string)g_CurrentFittedButState;
    xlProcessCommand(TRUE);
    g_LastCommand_s = "setnip:" + (string)g_CurrentFittedNipState;
    xlProcessCommand(TRUE);
    g_LastCommand_s = "setvag:" + (string)g_CurrentFittedVagState;
    xlProcessCommand(TRUE);
    g_LastCommand_s = "nipalpha:" + (string)g_CurrentFittedNipAlpha;
    xlProcessCommand(TRUE);
  }

  integer AnimsCount = llGetInventoryNumber(INVENTORY_ANIMATION);
  integer index = 0;
  string name;

  for(; index < AnimsCount; index++) {
    name = llGetInventoryName(INVENTORY_ANIMATION, index);

    if(g_AnimUndeform == "") {
      if(llSubStringIndex(name, "undeform") > -1) {
        g_AnimUndeform = name;
      }
    }

    if(g_AnimDeform == "") {
      if(llSubStringIndex(name, "deform") > -1
          && llSubStringIndex(name, "undeform") == -1) {
        g_AnimDeform = name;
      }
    }
  }

  list data = llParseString2List(llGetObjectDesc(), ["*"], []);
  human_mode = llList2Integer(data, 1);
  string color_desc = llList2String(data, 2);

  if(llSubStringIndex(color_desc, "<") != -1) {
    g_Config_BladeColor = (vector)color_desc;
  }

  if(llListFindList(g_LinkDB_l, [ "LFleg" ]) == -1
      && llListFindList(g_LinkDB_l, [ "RFleg" ]) == -1) {
    g_LastCommand_s = "Hlegs";
    xlProcessCommandWrapper();

  } else if(llListFindList(g_LinkDB_l, [ "LHleg" ]) == -1
            && llListFindList(g_LinkDB_l, [ "RHleg" ]) == -1) {
    g_LastCommand_s = "Flegs";
    xlProcessCommandWrapper();
  }
}

default
{
  changed(integer change) {
    if(change & CHANGED_OWNER) {
      llResetScript();

    } else if(change & CHANGED_LINK) {
      detectLinkSetMods();
    }
  }
  state_entry() {
    s_KFTPelvisMeshes_size = s_KFTPelvisMeshes_size;
    g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings & (~ 1)) ;
    g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings | 1) ;
    g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings & (~ 1)) ;

    if(g_Config_EnsureMaskingMode) {
      integer aaa = 0;

      for(; aaa <= llGetNumberOfPrims(); aaa++) {
        llSetLinkPrimitiveParamsFast(aaa, [PRIM_ALPHA_MODE, ALL_SIDES,
                                           PRIM_ALPHA_MODE_MASK, 75]);
      }
    }

    string self = llGetScriptName();
    string basename = "Enhanced Kemono Body";
    string tail = "MISSING_VERSION";

    if(llSubStringIndex(self, " ") >= 0) {
      integer start = 2;
      tail = llGetSubString(self, llStringLength(self) - start, -1);

      while(llGetSubString(tail, 0, 0) != " ") {
        start++;
        tail = llGetSubString(self, llStringLength(self) - start, -1);
      }

      if((integer)tail > 0) {
        basename = llGetSubString(self, 0, -llStringLength(tail) - 1);
      }
    }

    integer n = llGetInventoryNumber(INVENTORY_SCRIPT);

    while(n-- > 0) {
      string item = llGetInventoryName(INVENTORY_SCRIPT, n);

      if(item != self) {
        if(-1 != llSubStringIndex(item, "[Kemono 1.")
            || -1 != llSubStringIndex(item, "[AdvKem")) {
          llRemoveInventory(item);

        } else if(-1 != llSubStringIndex(item, basename)) {
          llRemoveInventory(item);
        }
      }
    }

    if(llGetSubString(llGetObjectName(), 0,
                      llStringLength("[XenLab] Enhanced Kemono Updater") - 1) ==
        "[XenLab] Enhanced Kemono Updater") {
      llSetObjectDesc(g_internal_version_s + "*" + (string)human_mode + "*" +
                      (string)g_Config_BladeColor) ;
      llSetObjectName("[XenLab] Enhanced Kemono Updater"  + " v" +
                      g_internal_version_s);
      llSleep(999);
      llResetScript();
    }

    g_Owner_k = llGetOwner();
    detectLinkSetMods();

    if(llGetAttached()) {
      llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_COLOR, ALL_SIDES,
                                   g_Config_BladeColor, 0.0]);
      llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);

    } else {
      llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_COLOR, ALL_SIDES,
                                   g_Config_BladeColor, 1.0]);
    }

    g_LastCommand_s = "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
                      + "shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
                      + "thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
                      + "shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
                      + "elbowR:armLL:armLR:wristL:wristR:handL:handR";
    xlProcessCommand(TRUE);
    llRegionSayTo(g_Owner_k,  -34525475 ,
                  "show:neck:collar:shoulderUL:shoulderUR:"
                  + "shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
                  + "hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
                  + "shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
                  + "armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
    llSetText("", ZERO_VECTOR, 0.0);
    llListen(-34525475 , "", "", "");
    llWhisper(-34525475 , "reqCLdat");
  }
  listen(integer channel, string name, key id, string message) {
    key object_owner_k = llGetOwnerKey(id);

    if(object_owner_k != g_Owner_k) {
      if(object_owner_k != id) {
        return;
      }

      if(llListFindList(g_AttmntAuthedKeys_l, [id]) == -1) {
        return;
      }

    } else {
      integer separatorIndex = llSubStringIndex(g_LastCommand_s, ":");

      if(separatorIndex < 0) {
        separatorIndex = 0;
      }

      string first_command = llGetSubString(g_LastCommand_s, 0, separatorIndex - 1);

      if(first_command == "add") {
        if(llGetFreeMemory() > 2048) {
          if(id != g_Owner_k) {
            if(llListFindList(g_AttmntAuthedKeys_l, [id]) == -1) {
              g_AttmntAuthedKeys_l += [id];
            }
          }
        }
      }
    }

    g_LastCommand_s = message;
    g_Last_k = id;
    xlProcessCommandWrapper();
    g_Last_k = NULL_KEY;

    if(llGetAttached()) {
      if(!g_HasAnimPerms) {
        llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);

      } else {
        llStopAnimation(g_AnimUndeform);
        llStopAnimation(g_AnimUndeform);
      }
    }
  }
  on_rez(integer p) {
    llSetObjectDesc(g_internal_version_s + "*" + (string)human_mode + "*" +
                    (string)g_Config_BladeColor) ;
  }
  attach(key id) {
    if(llGetSubString(llGetObjectName(), 0,
                      llStringLength("[XenLab] Enhanced Kemono Updater") - 1) ==
        "[XenLab] Enhanced Kemono Updater") {
      return;
    }

    if(id == NULL_KEY) {
      if(g_HasAnimPerms) {
        {
          llStartAnimation(g_AnimUndeform);
        } ;
        {
          llStartAnimation("stand_1");
        } ;
        llStopAnimation(g_AnimDeform);
        llStopAnimation(g_AnimUndeform);
      }

    } else {
      llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);

      if(g_HasAnimPerms) {
        {
          llStartAnimation(g_AnimDeform);
        } ;
        llStopAnimation(g_AnimUndeform);
        llStopAnimation(g_AnimUndeform);
      }

      reset();
      llRegionSayTo(g_Owner_k,  -34525475 ,
                    "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
    }
  }
  run_time_permissions(integer perm) {
    if(perm & PERMISSION_TRIGGER_ANIMATION) {
      g_HasAnimPerms = TRUE;
    }

    llRegionSayTo(g_Owner_k,  -34525475 ,
                  "show:neck:collar:shoulderUL:shoulderUR:"
                  + "shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
                  + "hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
                  + "shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
                  + "armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
    llSetTimerEvent(1);
  }
  timer() {
    if(llGetAttached()) {
      integer new_anim_count = llGetListLength(llGetAnimationList(g_Owner_k));

      if(anim_count != new_anim_count) {
        anim_count = new_anim_count;

        if(g_HasAnimPerms) {
          {
            llStartAnimation(g_AnimDeform);
          } ;

        } else {
          llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
        }
      }
    }
  }
  link_message(integer sender_num, integer num, string message, key id) {
    llOwnerSay("LINK MESSAGE[" + (string)id + "]: '" + message + "'");
  }
}

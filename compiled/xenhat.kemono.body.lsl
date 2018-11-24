float g_Config_MaximumOpacity=1.00;
key g_internal_httprid_k=NULL_KEY;
integer g_CurrentFittedButState=1;
integer g_CurrentFittedNipState=1;
integer g_CurrentFittedNipAlpha=0;
integer g_CurrentFittedVagState=1;
integer g_PreviousFittedButState=1;
integer g_PreviousFittedNipState=1;
integer g_PreviousFittedNipAlpha=0;
integer g_PreviousFittedVagState=1;
integer g_HasAnimPerms=FALSE;
integer g_RuntimeBodyStateSettings;

integer human_mode=TRUE;
key g_Owner_k;
key g_Last_k;
list g_LinkDB_l=[];
list g_AttmntAuthedKeys_l;
string g_LastCommand_s;

string g_AnimDeform;
string g_AnimUndeform;
list xlGetFacesByBladeName(string name) {
  if(name== "abs") return [6,7];
  if(name== "ankleL") {
    if(human_mode) return [1];
    return [5];
  }
  if(name== "ankleR") {
    if(human_mode)
      return [1];
    return [5];
  }
  if(name== "armLL") return [7];
  if(name== "armLR") return [2];
  if(name== "armUL") return [0];
  if(name== "armUR") return [6];
  if(name== "belly") return [2,3];
  if(name== "body") return [0];
  if(name== "breast") {
    if(g_RuntimeBodyStateSettings & 1)
      return [2,3];
    return [2,5];
  }
  if(name== "calfL") {
    if(human_mode)
      return [4];
    return [2];
  }
  if(name== "calfR") {
    if(human_mode)
      return [4];
    return [2];
  }
  if(name== "chest") {
    if(g_RuntimeBodyStateSettings & 1)
      return [0,1];
    if(human_mode)
      return [0,4];
    return [0,4];
  }
  if(name== "collar") {
    if(g_RuntimeBodyStateSettings & 1)
      return [6,7];
    return [1,6];
  }
  if(name== "elbowL") return [4];
  if(name== "elbowR") return [5];
  if(name== "footL") return [0];
  if(name== "footR") return [0];
  if(name== "hipL") {
    if(g_RuntimeBodyStateSettings & 1)
      return [5];
    return [6];
  }
  if(name== "hipR") {
    if(g_RuntimeBodyStateSettings & 1)
      return [4];
    return [5];
  }
  if(name== "kneeL") {
    if(human_mode)
      return [5];
    return [1];
  }
  if(name== "kneeR") {
    if(human_mode)
      return [5];
    return [1];
  }
  if(name== "handL")
    return [-1];
  if(name== "handR")
    return [-1];
  if(name== "neck") {
    if(g_RuntimeBodyStateSettings & 1)
      return [0,1];
    return [2,5];
  }
  if(name== "nips") {
    if(g_RuntimeBodyStateSettings & 1)
      return [0,1];
    return [2,3];
  }
  if(name== "pelvis") {
    if(g_RuntimeBodyStateSettings & 1)
      return [0,1,2,3];
    return [0,1];
  }
  if(name== "ribs") {
    if(g_RuntimeBodyStateSettings & 1)
      return [4,5];
    return [1,3];
  }
  if(name== "shinLL") {
    if(human_mode)
      return [2];
    return [4];
  }
  if(name== "shinLR") {
    if(human_mode)
      return [2];
    return [4];
  }
  if(name== "shinUL")
    return [3];
  if(name== "shinUR")
    return [3];
  if(name== "shoulderLL")
    return [3];
  if(name== "shoulderLR") {
    if(g_RuntimeBodyStateSettings & 1)
      return [2];
    return [0];
  }
  if(name== "shoulderUL") {
    if(g_RuntimeBodyStateSettings & 1)
      return [5];
    return [7];
  }
  if(name== "shoulderUR")
    return [4];
  if(name== "thighLL") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode)
        return [1];
      return [7];
    }
    return [6];
  }
  if(name== "thighLR") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode)
        return [0];
      return [6];
    }
    return [6];
  }
  if(name== "thighUL") {
    if(g_RuntimeBodyStateSettings & 1)
      return [5];
    return [7];
  }
  if(name== "thighUR") return [4];
  if(name== "vagoo") {
    if(g_RuntimeBodyStateSettings & 1)
      return [0,1];
    return [0,1];
  }
  if(name== "butt") {
    if(g_RuntimeBodyStateSettings & 1)
      return [2,3,4,5];
    return [];
  }
  if(name== "wristL") return [3];
  if(name== "wristR") return [1];
  return [];
}
list xlBladeNameToPrimNames(string name) {
  if(name== "armLL") return [ "arms" ];
  else if(name== "armLR") return [ "arms" ];
  else if(name== "armUL") return [ "arms" ];
  else if(name== "armUR") return [ "arms" ];
  else if(name== "elbowL") return [ "arms" ];
  else if(name== "elbowR") return [ "arms" ];
  else if(name== "wristL") return [ "arms" ];
  else if(name== "wristR") return [ "arms" ];
  else if(name== "ribs") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoChest" ];
    return [ "body" ];
  } else if(name== "abs") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoChest" ];
    return [ "body" ];
  } else if(name== "body") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoChest" ];
    return [ "body" ];
  } else if(name== "breast") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoChest" ];
    return [ "body" ];
  } else if(name== "chest") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoChest" ];
    return [ "body" ];
  } else if(name== "collar") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "Fitted Kemono Torso" ];
    return [ "neck" ];
  } else if(name== "handL") return [ "handL" ];
  else if(name== "handR") return [ "handR" ];
  else if(name== "hipL"  || name== "hipR") {
    if(g_RuntimeBodyStateSettings & 1)
      return [llList2String([ "BitState0", "BitState1", "BitState2", "BitState3" ] ,
                            g_CurrentFittedVagState)];
    return [ "hips" ];
  } else if(name== "neck") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "Fitted Kemono Torso" ];
    return [ "neck" ];
  } else if(name== "pelvis") {
    if(g_RuntimeBodyStateSettings & 1)
      return [llList2String([ "BitState0", "BitState1", "BitState2", "BitState3" ] ,
                            g_CurrentFittedVagState)];
    return [ "hips" ];
  } else if(name== "kneeR") {
    if(human_mode)
      return [ "RHleg" ];
    return [ "RFleg" ];
  } else if(name== "footR") {
    if(human_mode)
      return [ "RHleg" ];
    return [ "RFleg" ];
  } else if(name== "ankleR") {
    if(human_mode)
      return [ "RHleg" ];
    return [ "RFleg" ];
  } else if(name== "shinUR") {
    if(human_mode)
      return [ "RHleg" ];
    return [ "RFleg" ];
  } else if(name== "calfR") {
    if(human_mode)
      return [ "RHleg" ];
    return [ "RFleg" ];
  } else if(name== "shinLR") {
    if(human_mode)
      return [ "RHleg" ];
    return [ "RFleg" ];
  } else if(name== "calfL") {
    if(human_mode)
      return [ "LHleg" ];
    return [ "LFleg" ];
  } else if(name== "ankleL") {
    if(human_mode)
      return [ "LHleg" ];
    return [ "LFleg" ];
  } else if(name== "footL") {
    if(human_mode)
      return [ "LHleg" ];
    return [ "LFleg" ];
  } else if(name== "kneeL") {
    if(human_mode)
      return [ "LHleg" ];
    return [ "LFleg" ];
  } else if(name== "shinLL") {
    if(human_mode)
      return [ "LHleg" ];
    return [ "LFleg" ];
  } else if(name== "shinUL") {
    if(human_mode)
      return [ "LHleg" ];
    return [ "LFleg" ];
  } else if(name== "shoulderLL") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "Fitted Kemono Torso" ];
    return [ "neck" ];
  } else if(name== "shoulderLR") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "Fitted Kemono Torso" ];
    return [ "neck" ];
  } else if(name== "shoulderUL") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "Fitted Kemono Torso" ];
    return [ "neck" ];
  } else if(name== "shoulderUR") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "Fitted Kemono Torso" ];
    return [ "neck" ];
  } else if(name== "thighUL") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoEtc" ];
    return [ "hips" ];
  } else if(name== "thighUR") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoEtc" ];
    return [ "hips" ];
  } else if(name== "belly") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "TorsoEtc" ];
    return [ "hips" ];
  } else if(name== "nips") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(1==g_CurrentFittedNipAlpha)
        return [ "NipAlpha" ];
      else if(2==g_CurrentFittedNipAlpha)
        return [ "NipState0" ];
      else {
        return [llList2String([ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] ,
                              g_CurrentFittedNipState)];
      }
    }
    return [ "PG" ];
  } else if(name== "NipAlpha") {
    if(g_RuntimeBodyStateSettings & 1)
      return [ "NipAlpha" ];
    return [ "PG" ];
  } else if(name== "vagoo") {
    if(g_RuntimeBodyStateSettings & 1)
      return [llList2String([ "BitState0", "BitState1", "BitState2", "BitState3" ] ,
                            g_CurrentFittedVagState)];
    return [ "PG" ];
  } else if(name== "thighLR") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode)
        return [ "HumanLegs" ];
      return [ "TorsoEtc" ];
    }
    if(human_mode)
      return [ "RHleg" ];
    return [ "RFleg" ];
  } else if(name== "thighLL") {
    if(g_RuntimeBodyStateSettings & 1) {
      if(human_mode)
        return [ "HumanLegs" ];
      return [ "TorsoEtc" ];
    }
    if(human_mode)
      return [ "LHleg" ];
    return [ "LFleg" ];
  }
  return [name];
}
xlProcessCommandWrapper() {
  if(g_LastCommand_s ==
      "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR")
    reset();
  else if(g_LastCommand_s=="resetA")
    reset();
  else if(g_LastCommand_s=="resetB") {
    g_AttmntAuthedKeys_l=[];
    reset();
  } else if(g_LastCommand_s=="Hlegs") {
    if(!human_mode) {
      g_LastCommand_s =
        "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
      xlProcessCommand(TRUE);
      human_mode=TRUE;
      g_LastCommand_s =
        "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
      xlProcessCommand(TRUE);
    }
    llSetObjectDesc((string)(human_mode) + "," +  "0.3.32");
  } else if(g_LastCommand_s=="Flegs") {
    if(human_mode) {
      g_LastCommand_s =
        "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
      xlProcessCommand(TRUE);
      human_mode=FALSE;
      g_LastCommand_s =
        "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
      xlProcessCommand(TRUE);
    }
    llSetObjectDesc((string)(human_mode) + "," +  "0.3.32");
  } else if(g_LastCommand_s == "Rhand:1") {
    llStartAnimation("Kem-hand-R-relax");
    llStopAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-point");
    return;
  } else if(g_LastCommand_s == "Rhand:2") {
    llStartAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-point");
    llStopAnimation("Kem-hand-R-relax");
    return;
  } else if(g_LastCommand_s == "Rhand:3") {
    llStartAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-point");
    llStopAnimation("Kem-hand-R-relax");
    return;
  } else if(g_LastCommand_s == "Rhand:4") {
    llStartAnimation("Kem-hand-R-point");
    llStopAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-relax");
    return;
  } else if(g_LastCommand_s == "Rhand:5") {
    llStartAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-point");
    llStopAnimation("Kem-hand-R-relax");
    return;
  } else if(g_LastCommand_s == "Lhand:1") {
    llStartAnimation("Kem-hand-L-relax");
    llStopAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-point");
    return;
  } else if(g_LastCommand_s == "Lhand:2") {
    llStartAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-point");
    llStopAnimation("Kem-hand-L-relax");
    return;
  } else if(g_LastCommand_s == "Lhand:3") {
    llStartAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-point");
    llStopAnimation("Kem-hand-L-relax");
    return;
  } else if(g_LastCommand_s == "Lhand:4") {
    llStartAnimation("Kem-hand-L-point");
    llStopAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-relax");
    return;
  } else if(g_LastCommand_s == "Lhand:5") {
    llStartAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-point");
    llStopAnimation("Kem-hand-L-relax");
    return;
  } else if("reqFTdat"==g_LastCommand_s) {
    if(g_RuntimeBodyStateSettings & 1) {
      llRegionSayTo(g_Owner_k, -34525475 ,"resFTdat:nipState:"
                    +(string)g_CurrentFittedNipState
                    +":nipAlpha:"+(string)g_CurrentFittedNipAlpha
                    +":nipOvrd:0"
                    +":vagState:"+(string)g_CurrentFittedVagState
                    +":buttState:"+(string)g_CurrentFittedButState
                    +":humLegs:"+(string)human_mode);
    }
    return;
  } else {
    if(llSubStringIndex(g_LastCommand_s, "resCLdat")==0) {
      if(g_RuntimeBodyStateSettings & 1) {
        list data = llParseString2List(g_LastCommand_s,[":"], []);
        string clothDesc = llList2String(data,4);
        integer attachPoint = llList2Integer(data,6);
        if("Top"==clothDesc) {
          if(0==attachPoint) {
            g_LastCommand_s="setnip:"+(string)g_PreviousFittedNipState;
            xlProcessCommand(TRUE);
          } else
            g_PreviousFittedNipState=g_CurrentFittedNipState;
        }
      }
      return;
    }
    xlProcessCommand(TRUE);
  }
}
xlProcessCommand(integer send_params) {
  list input_data = llParseString2List(g_LastCommand_s,[":"],[]);
  string command = llList2String(input_data,0);
  integer list_size = llGetListLength(input_data);
  integer index = 0;
  integer i_make_visible = -1;
  list local_params;
  integer mesh_count_index=0;
  integer mod_command = -1;
  integer mod_command_2 = -1;
  for(; index < list_size ; index++) {
    command = llList2String(input_data,index);
    if(0==index) {
      if("setnip"==command) {
        {
          mesh_count_index= ((llGetListLength([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                                "NipAlpha" ]))-1) ;
          mod_command= 16 ;
          mod_command_2= 4 ;
        }
      } else if("nipalpha"==command) {
        mesh_count_index= ((llGetListLength([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                              "NipAlpha" ]))-1) ;
        mod_command= 64 ;
        mod_command_2= 4 ;
      } else if("setbutt"==command) {
        mesh_count_index= ((llGetListLength([ "BitState0", "BitState1", "BitState2",
                                              "BitState3" ]))-1) ;
        mod_command= 8 ;
        mod_command_2= 4 ;
      } else if("setvag"==command) {
        mesh_count_index= ((llGetListLength([ "BitState0", "BitState1", "BitState2",
                                              "BitState3" ]))-1) ;
        mod_command_2= 4 ;
        mod_command= 32 ;
      } else if("show"==command)
        i_make_visible = TRUE;
      else if("hide"==command)
        i_make_visible = FALSE;
      else if("remove"==command) {
        integer placeinlist=llListFindList(g_AttmntAuthedKeys_l,[g_Last_k]);
        if(placeinlist !=-1) {
          g_AttmntAuthedKeys_l=llDeleteSubList(g_AttmntAuthedKeys_l,
                                               placeinlist,placeinlist);
        }
      } else if(llListFindList(["tail","skin","add" ] ,[command]) == -1)
        llOwnerSay("Unhandled command '"+command+"' from " + llKey2Name(g_Last_k));
    } else {
      if(mod_command<1) {
        if("nips" ==command) {
          if(g_RuntimeBodyStateSettings & 1) {
            mod_command= 2 ;
            mod_command_2= 4 ;
          } else {
            mod_command= 2 ;
            mod_command_2= 2 ;
          }
          g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 2)) |
                                     (2 * !i_make_visible); ;
        } else if("vagoo" ==command) {
          mod_command= 4 ;
          mod_command_2= 2 ;
          g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 4)) |
                                     (4 * !i_make_visible); ;
        } else
          mod_command_2= 2 ;
      }
      if(4 ==mod_command_2) {
        integer param = llList2Integer(input_data,index);
        string mesh_name="";
        for(; mesh_count_index > -1; mesh_count_index--) {
          if(2 ==mod_command) {
            g_LastCommand_s="setnip:"+(string)i_make_visible;
            xlProcessCommand(TRUE);
          }
          if(64 ==mod_command) {
            g_CurrentFittedNipAlpha=param;
            mesh_name=llList2String([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                      "NipAlpha" ] ,mesh_count_index);
            i_make_visible=(g_CurrentFittedNipAlpha==1) * (mesh_count_index==3);
            if(0==param) {
              mod_command= 16 ;
              param=g_PreviousFittedNipState;
            } else
              g_PreviousFittedNipState=g_CurrentFittedNipState;
          }
          if(16 ==mod_command) {
            g_CurrentFittedNipState=param;
            if(!g_CurrentFittedNipAlpha) {
              {
                i_make_visible=
                  (mesh_count_index==g_CurrentFittedNipState);
                mesh_name=llList2String([ "NipState0" , "TorsoEtc" , "NipState1" ,
                                          "NipAlpha" ] ,mesh_count_index);
              }
            }
          } else if(32 ==mod_command) {
            g_CurrentFittedVagState=param;
            i_make_visible=
              (mesh_count_index==param);
            mesh_name=llList2String([ "BitState0", "BitState1", "BitState2", "BitState3" ] ,
                                    mesh_count_index);
          } else if(8 ==mod_command) {
            g_CurrentFittedButState=param;
            i_make_visible=
              (mesh_count_index==param);
            mesh_name=llList2String([ "BitState0", "BitState1", "BitState2", "BitState3" ] ,
                                    mesh_count_index);
          }
          if(llStringLength(mesh_name)>0) {
            list prim_names = xlBladeNameToPrimNames(mesh_name);
            integer link_id=llList2Integer(g_LinkDB_l,
                                           llListFindList(g_LinkDB_l,prim_names)+1);
            local_params +=[PRIM_LINK_TARGET,link_id];
            list faces_l=[];
            if(16 ==mod_command ||  2 ==mod_command)
              faces_l=xlGetFacesByBladeName("nips");
            else if(32 ==mod_command)
              faces_l=xlGetFacesByBladeName("vagoo");
            else if(64 ==mod_command)
              faces_l=xlGetFacesByBladeName("nips");
            else if(8 ==mod_command)
              faces_l=xlGetFacesByBladeName("butt");
            integer faces_count= ((llGetListLength(faces_l))-1)  + 1;
            integer i2 = 0;
            for(; i2 < faces_count; i2++) {
              local_params+=[PRIM_COLOR,
                             llList2Integer(faces_l,i2),<1,1,1>,
                             i_make_visible * g_Config_MaximumOpacity
                            ];
            }
          }
        }
      } else if(2 ==mod_command_2) {
        list prim_names=xlBladeNameToPrimNames(command);
        local_params+=[
                        PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,
                            llListFindList(g_LinkDB_l,prim_names)+1)
                      ];
        list faces_l=xlGetFacesByBladeName(command);
        integer faces_index= ((llGetListLength(faces_l))-1) ;
        for(; faces_index > -1; faces_index--) {
          local_params+=[
                          PRIM_COLOR,llList2Integer(faces_l,faces_index),<1,1,1>,
                          (i_make_visible) *
                          g_Config_MaximumOpacity
                        ];
        }
        if("breast" ==command) {
          if(g_RuntimeBodyStateSettings & 1) {
            list faces = xlGetFacesByBladeName("nips");
            list snd_lvl_params = [
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l,[ "NipState0" ])+1),
                                    PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 0
                                        ||  g_RuntimeBodyStateSettings & 2
                                       ),
                                    PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 0
                                        ||  g_RuntimeBodyStateSettings & 2
                                       ),
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l,[ "TorsoEtc" ])+1),
                                    PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 1
                                        && ! g_RuntimeBodyStateSettings & 2
                                        && (g_CurrentFittedNipAlpha < 1)),
                                    PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 1
                                        && ! g_RuntimeBodyStateSettings & 2
                                        && (g_CurrentFittedNipAlpha < 1)),
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l,[ "NipState1" ])+1),
                                    PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 2
                                        && ! g_RuntimeBodyStateSettings & 2
                                        && (g_CurrentFittedNipAlpha < 1)),
                                    PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 2
                                        && ! g_RuntimeBodyStateSettings & 2
                                        && (g_CurrentFittedNipAlpha < 1)),
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l,[ "NipAlpha" ])+1),
                                    PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible && (g_CurrentFittedNipAlpha > 0
                                        && ! g_RuntimeBodyStateSettings & 2),
                                    PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible && (g_CurrentFittedNipAlpha > 0
                                        && ! g_RuntimeBodyStateSettings & 2)
                                  ];
            local_params+=snd_lvl_params;
          }
        }
      }
    }
  }
  if(send_params)
    llSetLinkPrimitiveParamsFast(LINK_ROOT,local_params) ;
  local_params=[];
}
redeform() {
  if(g_HasAnimPerms) {
    llStartAnimation(g_AnimDeform);
    llStopAnimation(g_AnimUndeform);
  }
}
resetHands() {
  if(g_HasAnimPerms) {
    llStartAnimation("Kem-hand-R-relax");
    llStartAnimation("Kem-hand-L-relax");
    llStopAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-point");
    llStopAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-point");
    redeform();
  }
}
reset() {
  if(g_RuntimeBodyStateSettings & 1) {
    integer i;
    list params;
    for(i=0; i<llGetListLength([ "BitState0", "BitState1", "BitState2",
                                 "BitState3" ]); i++) {
      string mesh_name = llList2String([ "BitState0", "BitState1", "BitState2",
                                         "BitState3" ] ,i);
      list prim_names = xlBladeNameToPrimNames(mesh_name);
      integer link_id=llList2Integer(g_LinkDB_l,
                                     llListFindList(g_LinkDB_l,prim_names)+1);
      params+=[PRIM_LINK_TARGET,link_id];
      params +=[PRIM_COLOR,ALL_SIDES,<1,1,1>,0.0];
    }
    llSetLinkPrimitiveParamsFast(LINK_ROOT, params);
  }
  g_LastCommand_s=
    "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR"
    ;
  xlProcessCommand(TRUE);
  if(g_RuntimeBodyStateSettings & 1) {
    g_LastCommand_s = ":nipalpha:"+(string) 0 ;
    xlProcessCommand(TRUE);
    g_LastCommand_s = ":setnip:"+(string) 1 ;
    xlProcessCommand(TRUE);
  }
  resetHands();
}
detectLinkSetMods() {
  integer part=llGetNumberOfPrims();
  integer found_fitted_torso = FALSE;
  for(; part > 0; --part) {
    string name=llGetLinkName(part);
    if(!found_fitted_torso) {
      if(name ==  "Fitted Torso Old Root") {
        found_fitted_torso = TRUE;
        name= "Fitted Kemono Torso" ;
      } else if(llSubStringIndex(name, "Kemono")!=-1 &&
                llSubStringIndex(name, "Torso")!=-1 &&
                (llSubStringIndex(name, "Petite")!=-1 ||
                 llSubStringIndex(name, "Busty")!=-1)) {
        found_fitted_torso = TRUE;
        llSetLinkPrimitiveParams(part, [PRIM_NAME, "Fitted Torso Old Root" ]);
        name= "Fitted Kemono Torso" ;
      }
    }
    if(llListFindList(["BitState0","BitState1","BitState2","BitState3","cumButtS1",
                       "cumButtS2","cumButtS3", "arms" , "body" , "Fitted Kemono Torso" ,
                       "TorsoChest" , "TorsoEtc" , "HumanLegs" , "NipState0" , "NipState1" ,
                       "NipAlpha" , "handL" , "handR" , "hips" , "LFleg" , "LHleg" , "RFleg" ,
                       "RHleg" , "neck" , "PG" , "Kemono - Body" ] ,[name])!=-1)
      g_LinkDB_l+=[name,part];
  }
  if(found_fitted_torso)
    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings | 1) ;
  g_AnimDeform=llGetInventoryName(INVENTORY_ANIMATION,0);
  g_AnimUndeform=llGetInventoryName(INVENTORY_ANIMATION,1);
  list data = llCSV2List(llGetObjectDesc());
  human_mode = llList2Integer(data,0);
  if(llListFindList(g_LinkDB_l,[ "LFleg" ]) == -1
      && llListFindList(g_LinkDB_l,[ "RFleg" ]) == -1) {
    g_LastCommand_s="Hlegs";
    xlProcessCommandWrapper();
    llOwnerSay("Adjusted for missing animal legs");
  } else if(llListFindList(g_LinkDB_l,[ "LHleg" ]) == -1
            && llListFindList(g_LinkDB_l,[ "RHleg" ]) == -1) {
    g_LastCommand_s="Flegs";
    xlProcessCommandWrapper();
    llOwnerSay("Adjusted for missing human legs");
  }
}
default {
  changed(integer change) {
    if(change & CHANGED_OWNER)
      llResetScript();
    else if(change & CHANGED_LINK) {
      llOwnerSay("Linkset changed, resetting...");
      detectLinkSetMods();
    }
  }
  state_entry() {
    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 1)) ;
    ;
    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings | 1) ;
    ;
    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 1)) ;
    ;
    if(llGetObjectName()== "[XenLab] Enhanced Kemono Updater") {
      llSetObjectDesc((string)(human_mode) + "," +  "0.3.32");
      state dead;
    }
    string self=llGetScriptName();
    string basename=self;
    string tail = "MISSING_VERSION";
    if(llSubStringIndex(self," ") >= 0) {
      integer start=2;
      tail=llGetSubString(self,llStringLength(self) - start,-1);
      while(llGetSubString(tail,0,0)!=" ") {
        start++;
        tail=llGetSubString(self,llStringLength(self) - start,-1);
      }
      if((integer)tail > 0)
        basename=llGetSubString(self,0,-llStringLength(tail) - 1);
    }
    integer n=llGetInventoryNumber(INVENTORY_SCRIPT);
    while(n-- > 0) {
      string item=llGetInventoryName(INVENTORY_SCRIPT,n);
      if(item != self && 0 == llSubStringIndex(item,basename)) {
        llRemoveInventory(item);
        llOwnerSay("Upgraded to "+ tail);
      }
    }
    g_Owner_k=llGetOwner();
    g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"
                                       + "XenHat/"+ "Kemono-Body-Script"
                                       +"/releases/latest?access_token="
                                       +"603ee815cda6fb45fcc16876effbda017f158bef",
                                       [HTTP_BODY_MAXLENGTH,16384],"");
    detectLinkSetMods();
    if(llGetAttached())
      llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
    llSetText("",ZERO_VECTOR,0.0);
    llListen(-34525475 ,"","","");
  }
  listen(integer channel,string name,key id,string message) {
    if(id != llGetKey()) {
      key object_owner_k=llGetOwnerKey(id);
      if(object_owner_k != g_Owner_k) {
        if(object_owner_k != id)
          return;
        if(llListFindList(g_AttmntAuthedKeys_l,[id]) == -1)
          return;
      } else {
        integer separatorIndex=llSubStringIndex(g_LastCommand_s,":");
        if(separatorIndex < 0) separatorIndex = 0;
        string first_command = llGetSubString(g_LastCommand_s, 0, separatorIndex-1);
        if(first_command=="add") {
          if(llGetFreeMemory() > 2048) {
            if(id != g_Owner_k) {
              if(llListFindList(g_AttmntAuthedKeys_l,[id])==-1)
                g_AttmntAuthedKeys_l +=[id];
            }
          }
        }
      }
      g_LastCommand_s = message;
      g_Last_k = id;
      xlProcessCommandWrapper();
      g_Last_k = NULL_KEY;
    }
  }
  on_rez(integer p) {
    llSleep(3);
    g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"
                                       + "XenHat/"+ "Kemono-Body-Script"
                                       +"/releases/latest?access_token="
                                       +"603ee815cda6fb45fcc16876effbda017f158bef",
                                       [HTTP_BODY_MAXLENGTH,16384],"");
  }
  attach(key id) {
    if(llGetObjectName()== "[XenLab] Enhanced Kemono Updater")
      return;
    if(id==NULL_KEY) {
      llStartAnimation(g_AnimUndeform);
      llStartAnimation("stand_1");
      llStopAnimation(g_AnimDeform);
      llStopAnimation(g_AnimUndeform);
    } else {
      llStartAnimation(g_AnimDeform);
      llStopAnimation(g_AnimUndeform);
      llStopAnimation(g_AnimUndeform);
    }
  }
  run_time_permissions(integer perm) {
    g_HasAnimPerms=TRUE;
    llSetTimerEvent(5);
  }
  timer() {
    if(!g_HasAnimPerms)
      llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
    else
      redeform();
    string text;
    text+="\n \n \n \n \n \n \n \n \n \n ";
    llSetText(text, <0.925,0.925,0.925> , 0.75);
  }
  http_response(key request_id,integer status,list metadata,string body) {
    if(request_id !=g_internal_httprid_k) return;
    g_internal_httprid_k=NULL_KEY;
    string new_version_s=llJsonGetValue(body,["tag_name"]);
    if(new_version_s== "0.3.32") return;
    list cur_version_l=llParseString2List("0.3.32" ,["."],[""]);
    list new_version_l=llParseString2List(new_version_s,["."],[""]);
    if(llList2Integer(new_version_l,0) > llList2Integer(cur_version_l,0))
      jump update;
    else if(llList2Integer(new_version_l,1) >
            llList2Integer(cur_version_l,1))
      jump update;
    else if(llList2Integer(new_version_l,2) >
            llList2Integer(cur_version_l,2))
      jump update;
    return;
    @update;
    string update_title=llJsonGetValue(body,["name"]);
    if(update_title=="﷕")update_title="";
    string update_description=llJsonGetValue(body,["body"]);
    if(update_description=="﷕")
      update_description="";
    string changelog = update_description;
    update_description="\nAn update is avaible! ("+ "0.3.32"  +"🡂"
                       +new_version_s+")\n\""
                       +update_title+"\"\n"+changelog+"\n";
    string link = "\nYour new script:\n[https://raw.githubusercontent.com/"
                  + "XenHat/"+ "Kemono-Body-Script" +"/"+new_version_s+"/compiled/"+
                  "xenhat.kemono.body.lsl" +" "
                  + "Kemono-Body-Script" +".lsl]";
    llOwnerSay(update_description+link);
    if(llStringLength(update_description) > (512 - llStringLength(link))) {
      update_description="Too many changes, see ["+"https://github.com/"
                         + "XenHat/"+ "Kemono-Body-Script"
                         +"/compare/"+ "0.3.32" +"..."+new_version_s+" Changes for "
                         + "0.3.32" +"🡂"+new_version_s+"]";
    }
    llDialog(g_Owner_k,update_description+link,[],-1);
  }
}
state dead {
  state_entry() {
  }
}

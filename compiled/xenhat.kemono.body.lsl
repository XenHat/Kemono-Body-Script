float g_Config_MaximumOpacity=1.00;
string KM_HUD_RESET_CMD = "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR";
integer g_CurrentFittedButState=1;
integer g_CurrentFittedNipState=1;
integer g_CurrentFittedVagState=1;
integer g_HasAnimPerms=FALSE;
integer g_RuntimeBodyStateSettings;
integer g_TogglingPGMeshes=FALSE;
integer human_mode=TRUE;
list global_params;

key g_internal_httprid_k=NULL_KEY;

key g_Owner_k;
list g_LinkDB_l=[];
list g_AttmntAuthedKeys_l;
string g_LastCommand_s;

string g_AnimDeform;
string g_AnimUndeform;

list xlGetFacesByBladeName(string name){
    if(name== "abs" ) return [6,7];
    if(name== "ankleL" ){
        if(human_mode) return [1];
        return [5];
    }
    if(name== "ankleR" ){
        if(human_mode)
            return [1];
        return [5];
    }
    if(name== "armLL" ) return [7];
    if(name== "armLR" ) return [2];
    if(name== "armUL" ) return [0];
    if(name== "armUR" ) return [6];
    if(name== "belly" ) return [2,3];
    if(name== "body" ) return [0];
    if(name== "breast" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [2,3];
        return [2,5];
    }
    if(name== "calfL" ){
        if(human_mode)
            return [4];
        return [2];
    }
    if(name== "calfR" ){
        if(human_mode)
            return [4];
        return [2];
    }
    if(name== "chest" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [0,1];
        if(human_mode)
            return [0,4];
        return [0,4];
    }
    if(name== "collar" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [6,7];
        return [1,6];
    }
    if(name== "elbowL" ) return [4];
    if(name== "elbowR" ) return [5];
    if(name== "footL" ) return [0];
    if(name== "footR" ) return [0];
    if(name== "hipL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [5];
        return [6];
    }
    if(name== "hipR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [4];
        return [5];
    }
    if(name== "kneeL" ){
        if(human_mode)
            return [5];
        return [1];
    }
    if(name== "kneeR" ){
        if(human_mode)
            return [5];
        return [1];
    }
    if(name== "handL" )
        return [-1];
    if(name== "handR" )
        return [-1];
    if(name== "neck" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [0,1];
        return [2,5];
    }
    if(name== "nips" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [0,1];
        return [2,3];
    }
    if(name== "pelvis" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [0,1,2,3];
        return [0,1];
    }
    if(name== "ribs" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [4,5];
        return [1,3];
    }
    if(name== "shinLL" ){
        if(human_mode)
            return [2];
        return [4];
    }
    if(name== "shinLR" ){
        if(human_mode)
            return [2];
        return [4];
    }
    if(name== "shinUL" )
        return [3];
    if(name== "shinUR" )
        return [3];
    if(name== "shoulderLL" )
        return [3];
    if(name== "shoulderLR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [2];
        return [0];
    }
    if(name== "shoulderUL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [5];
        return [7];
    }
    if(name== "shoulderUR" )
        return [4];
    if(name== "thighLL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            if(human_mode){
                return [1];
            }
            return [7];
        }
        return [6];
    }
    if(name== "thighLR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            if(human_mode)
                return [0];
            return [6];
        }
        return [6];
    }
    if(name== "thighUL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [5];
        return [7];
    }
    if(name== "thighUR" ) return [4];
    if(name== "vagoo" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            if(g_TogglingPGMeshes)
                return [0,1,2,3,4,5];
            return [0,1];
        }
        return [0,1];
    }
    if(name== "butt" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            if(g_TogglingPGMeshes)
                return [0,1,2,3,4,5];
            return [2,3,4,5];
        }
        return [];
    }
    if(name== "wristL" ) return [3];
    if(name== "wristR" ) return [1];
    return [];
}
list xlBladeNameToPrimNames(string name){
    if(name== "armLL" ) return [ "arms" ];
    else if(name== "armLR" ) return [ "arms" ];
    else if(name== "armUL" ) return [ "arms" ];
    else if(name== "armUR" ) return [ "arms" ];
    else if(name== "elbowL" ) return [ "arms" ];
    else if(name== "elbowR" ) return [ "arms" ];
    else if(name== "wristL" ) return [ "arms" ];
    else if(name== "wristR" ) return [ "arms" ];
    else if(name== "ribs" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoChest" ];
        return [ "body" ];
    }
    else if(name== "abs" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoChest" ];
        return [ "body" ];
    }
    else if(name== "body" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoChest" ];
        return [ "body" ];
    }
    else if(name== "breast" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoChest" ];
        return [ "body" ];
    }
    else if(name== "chest" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoChest" ];
        return [ "body" ];
    }
    else if(name== "collar" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "Fitted Kemono Torso" ];
        return [ "neck" ];
    }
    else if(name== "handL" ) return [ "handL" ];
    else if(name== "handR" ) return [ "handR" ];
    else if(name== "hipL"  || name== "hipR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [llList2String( ["BitState0","BitState1","BitState2","BitState3"] ,g_CurrentFittedVagState)];
        return [ "hips" ];
    }
    else if(name== "neck" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "Fitted Kemono Torso" ];
        return [ "neck" ];
    }
    else if(name== "pelvis" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [llList2String( ["BitState0","BitState1","BitState2","BitState3"] ,g_CurrentFittedVagState)];
        return [ "hips" ];
    }
    else if(name== "kneeR" ){
        if(human_mode)
            return [ "RHleg" ];
        return [ "RFleg" ];
    }
    else if(name== "footR" ){
        if(human_mode)
            return [ "RHleg" ];
        return [ "RFleg" ];
    }
    else if(name== "ankleR" ){
        if(human_mode)
            return [ "RHleg" ];
        return [ "RFleg" ];
    }
    else if(name== "shinUR" ){
        if(human_mode)
            return [ "RHleg" ];
        return [ "RFleg" ];
    }
    else if(name== "calfR" ){
        if(human_mode)
            return [ "RHleg" ];
        return [ "RFleg" ];
    }
    else if(name== "shinLR" ){
        if(human_mode)
            return [ "RHleg" ];
        return [ "RFleg" ];
    }
    else if(name== "calfL" ){
        if(human_mode)
            return [ "LHleg" ];
        return [ "LFleg" ];
    }
    else if(name== "ankleL" ){
        if(human_mode)
            return [ "LHleg" ];
        return [ "LFleg" ];
    }
    else if(name== "footL" ){
        if(human_mode)
            return [ "LHleg" ];
        return [ "LFleg" ];
    }
    else if(name== "kneeL" ){
        if(human_mode)
            return [ "LHleg" ];
        return [ "LFleg" ];
    }
    else if(name== "shinLL" ){
        if(human_mode)
            return [ "LHleg" ];
        return [ "LFleg" ];
    }
    else if(name== "shinUL" ){
        if(human_mode)
            return [ "LHleg" ];
        return [ "LFleg" ];
    }
    else if(name== "shoulderLL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "Fitted Kemono Torso" ];
        return [ "neck" ];
    }
    else if(name== "shoulderLR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "Fitted Kemono Torso" ];
        return [ "neck" ];
    }
    else if(name== "shoulderUL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "Fitted Kemono Torso" ];
        return [ "neck" ];
    }
    else if(name== "shoulderUR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "Fitted Kemono Torso" ];
        return [ "neck" ];
    }
    else if(name== "thighUL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoEtc" ];
        return [ "hips" ];
    }
    else if(name== "thighUR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoEtc" ];
        return [ "hips" ];
    }
    else if(name== "belly" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [ "TorsoEtc" ];
        return [ "hips" ];
    }
    else if(name== "nips" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            return [llList2String( [ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] ,
                        g_CurrentFittedNipState)];
        return [ "PG" ];
    }
    else if(name== "vagoo" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            if(g_TogglingPGMeshes)
                return [llList2String( ["BitState0","BitState1","BitState2","BitState3"] ,0)];
            return [llList2String( ["BitState0","BitState1","BitState2","BitState3"] ,g_CurrentFittedVagState)];
        return [ "PG" ];
    }
    else if(name== "thighLR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            if(human_mode){
                return [ "HumanLegs" ];
            }
            return [ "TorsoEtc" ];
        }
        if(human_mode){
            return [ "RHleg" ];
        }
        return [ "RFleg" ];
    }
    else if(name== "thighLL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            if(human_mode){
                return [ "HumanLegs" ];
            }
            return [ "TorsoEtc" ];
        }
        if(human_mode){
            return [ "LHleg" ];
        }
        return [ "LFleg" ];
    }
    return [name];
}
list g_genitalsParams_l;
xlSetGenitals(integer pTogglePart){
    integer meshes_count=0;
    if( 16 ==pTogglePart)
        meshes_count= ((llGetListLength( [ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] ))-1) ;
    else
        meshes_count= ((llGetListLength( ["BitState0","BitState1","BitState2","BitState3"] ))-1) ;
    integer visible=FALSE;
    string mesh_name="";
    for(;meshes_count > -1;meshes_count--){


        if( 16 ==pTogglePart)
            visible=! (!!(g_RuntimeBodyStateSettings & pTogglePart))  *
            (meshes_count==g_CurrentFittedNipState);
        else if( 32 ==pTogglePart)
            visible=! (!!(g_RuntimeBodyStateSettings & pTogglePart))  *
            (meshes_count==g_CurrentFittedVagState);
        else if( 8 ==pTogglePart)
            visible=! (!!(g_RuntimeBodyStateSettings & pTogglePart))  *
            (meshes_count==g_CurrentFittedButState);
        if( 16 ==pTogglePart)
            mesh_name=llList2String( [ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] ,meshes_count);
        else
            mesh_name=llList2String( ["BitState0","BitState1","BitState2","BitState3"] ,meshes_count);

        list prim_names = xlBladeNameToPrimNames(mesh_name);

            integer link_id=llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l
                ,prim_names)+1);
            g_genitalsParams_l +=[PRIM_LINK_TARGET,link_id];

            list faces_l=[];
            if( 16 ==pTogglePart)
                faces_l=xlGetFacesByBladeName( "nips" );
            else if( 32 ==pTogglePart)
                faces_l=xlGetFacesByBladeName( "vagoo" );
            else if( 8 ==pTogglePart)
                faces_l=xlGetFacesByBladeName( "butt" );
            integer faces_count= ((llGetListLength(faces_l))-1) ;
            for(;faces_count > -1;--faces_count)
                g_genitalsParams_l+=[PRIM_COLOR,
                    llList2Integer(faces_l,faces_count),<1,1,1>,
                        visible * g_Config_MaximumOpacity
                ];
    }
}

xlProcessCommandWrapper()
{
            if(g_LastCommand_s == KM_HUD_RESET_CMD){
                reset();
            }
            else if(g_LastCommand_s=="resetA")
                reset();
            else if(g_LastCommand_s=="resetB"){
                g_AttmntAuthedKeys_l=[];
                reset();
            }
            else if(llSubStringIndex(g_LastCommand_s, "show")==0 ||
                llSubStringIndex(g_LastCommand_s, "hide")==0 ||
                llSubStringIndex(g_LastCommand_s, "set")==0){
                xlProcessCommand(TRUE);
            }
            else if(g_LastCommand_s=="Hlegs"){


                if(!human_mode){
                    g_LastCommand_s = "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(FALSE);
                    human_mode=TRUE;
                    g_LastCommand_s = "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(TRUE);
                }

                llSetObjectDesc((string)(human_mode) + "," +  "0.3.22" );
            }
            else if(g_LastCommand_s=="Flegs"){

                if(human_mode){
                    g_LastCommand_s = "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(FALSE);
                    human_mode=FALSE;
                    g_LastCommand_s = "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(TRUE);
                }

                llSetObjectDesc((string)(human_mode) + "," +  "0.3.22" );
            }

            else if(g_LastCommand_s == "Rhand:1"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStartAnimation("Kem-hand-R-relax");
                return;
            }
            else if(g_LastCommand_s == "Rhand:2"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-hold");
                return;
            }
            else if(g_LastCommand_s == "Rhand:3"){
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-fist");
                return;
            }
            else if(g_LastCommand_s == "Rhand:4"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-point");
                return;
            }
            else if(g_LastCommand_s == "Rhand:5"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-horns");
                return;
            }
            else if(g_LastCommand_s == "Lhand:1"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStartAnimation("Kem-hand-L-relax");
                return;
            }
            else if(g_LastCommand_s == "Lhand:2"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-hold");
                return;
            }
            else if(g_LastCommand_s == "Lhand:3"){
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-fist");
                return;
            }
            else if(g_LastCommand_s == "Lhand:4"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-point");
                return;
            }
            else if(g_LastCommand_s == "Lhand:5"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-horns");
                return;
            }
            else if("reqFTdat"==g_LastCommand_s){
                if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
                    llRegionSayTo(g_Owner_k, -34525475 ,"resFTdat:nipState:"
                        +(string)g_CurrentFittedNipState
                        +":nipAlpha:0"
                        +":nipOvrd:0"
                        +":vagState:"+(string)g_CurrentFittedVagState
                        +":buttState:"+(string)g_CurrentFittedButState
                        +":humLegs:"+(string)human_mode);
                }
                return;
            }
             else{
                if(llSubStringIndex(g_LastCommand_s, "resCLdat")==0){
                return;
            }
        }
    }
xlProcessCommand(integer send_params){
    list data=llParseString2List(g_LastCommand_s,[":"],[]);
    string command=llList2String(data,0);
    integer showit;

    integer ftCommand;
    if(command=="show")
        showit=TRUE;
    else if(command=="hide")
        showit=FALSE;
    else if(command=="setbutt"){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            ftCommand=1;
            g_CurrentFittedButState=llList2Integer(data,1);
            xlSetGenitals( 8 );
        }

    }
    else if(command=="setvag"){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            ftCommand=2;
            g_CurrentFittedVagState=llList2Integer(data,1);
            xlSetGenitals( 32 );
        }

    }
    else if(command=="setnip"){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            ftCommand=3;
            g_CurrentFittedNipState=llList2Integer(data,1);
            xlSetGenitals( 16 );
        }

    }
    else{

        if(llListFindList(["Ani","eRo","Exp","LEy","REy","reqCLdat"],[llGetSubString(g_LastCommand_s,0,2)])==-1){
            llOwnerSay("Unhandled command: '"+g_LastCommand_s+"'");
        }

        return;
    }
    integer list_size= ((llGetListLength(data))-1) ;
    for(;list_size > 0;list_size--){

        string blade_name=llList2String(data,list_size);
        if(blade_name== "nips" ){
            if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
                g_CurrentFittedNipState=showit;
                xlSetGenitals( 16 );
            }
            else
            {

                g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings &
                    (~ 4 )) | ( 4  * !showit);
                if(!g_TogglingPGMeshes && !showit){
                    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 4 )) | ( 4 * TRUE); ;
                }
                else if(g_TogglingPGMeshes && showit)
                g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 4 )) | ( 4 * FALSE); ;
            }
        }
        else if(blade_name== "vagoo" ){
            if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
                g_CurrentFittedVagState=showit;
                g_TogglingPGMeshes=TRUE;
                xlSetGenitals( 32 );
                g_TogglingPGMeshes=FALSE;
            }
            else{
                g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings &
                    (~ 2 )) | ( 2  * !showit);

                if(!showit && !g_TogglingPGMeshes){
                    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 2 )) | ( 2 * TRUE); ;
                }
                else if(showit && g_TogglingPGMeshes)
                g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 2 )) | ( 2 * FALSE); ;
            }
        }
        else{
            list params_internal;
            if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
                if(blade_name== "breast" ){
                    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 16 )) | ( 16 * !showit); ;
                    xlSetGenitals( 16 );
                }
                else if(blade_name== "pelvis" ){
                    g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 32 )) | ( 32 * !showit); ;
                    xlSetGenitals( 32 );
                }
            }
            else{
            if(blade_name== "pelvis" ){
                if(!(g_RuntimeBodyStateSettings &  2 ) && !showit){
                    g_LastCommand_s = "hide:"+ "vagoo" ;
                    xlProcessCommand(FALSE);
                }
                else{
                    g_LastCommand_s = "show:"+ "vagoo" ;
                    xlProcessCommand(FALSE);
                }
            }
            else if(blade_name== "breast" ){
                    if(!(g_RuntimeBodyStateSettings &  4 ) && !showit){
                        g_LastCommand_s = "hide:"+ "nips" ;
                        xlProcessCommand(FALSE);
                    }
                        else{
                        g_LastCommand_s = "show:"+ "nips" ;
                        xlProcessCommand(FALSE);
                    }
                }
            }
            list prim_names=xlBladeNameToPrimNames(blade_name);
                    params_internal+=[
                    PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,
                        llListFindList(g_LinkDB_l,prim_names)+1)
                    ];
                    list faces_l=xlGetFacesByBladeName(blade_name);
                    integer faces_index= ((llGetListLength(faces_l))-1) ;
                for(;faces_index > -1; faces_index--){
                    params_internal+=[
                    PRIM_COLOR,llList2Integer(faces_l,faces_index),<1,1,1>,
                    (showit ^ ( "vagoo" ==blade_name)) *
                    g_Config_MaximumOpacity
                    ];
                }
            global_params+=params_internal;
        }
    }
    if(send_params){
        llSetLinkPrimitiveParamsFast(LINK_ROOT,global_params+g_genitalsParams_l) ;
        global_params=[];
        g_genitalsParams_l=[];
    }
}
redeform(){

        llOwnerSay("Redeform");
        llStopAnimation(g_AnimUndeform);
        llStartAnimation(g_AnimDeform);
}
resetHands()
{ if(llGetAttached()){
        llStopAnimation("Kem-hand-L-fist");
        llStopAnimation("Kem-hand-L-hold");
        llStopAnimation("Kem-hand-L-horns");
        llStopAnimation("Kem-hand-L-point");
        llStopAnimation("Kem-hand-R-fist");
        llStopAnimation("Kem-hand-R-hold");
        llStopAnimation("Kem-hand-R-horns");
        llStopAnimation("Kem-hand-R-point");
        llStartAnimation("Kem-hand-R-relax");
        llStartAnimation("Kem-hand-L-relax");
    }
    redeform();
}
reset(){
    resetHands();
    g_LastCommand_s=KM_HUD_RESET_CMD;
    xlProcessCommand(TRUE);
}
default {
    changed(integer change){
        if(change & CHANGED_OWNER){
            llResetScript();
        }
        else if(change & CHANGED_LINK){
            llOwnerSay("Linkset changed, resetting...");
            llResetScript();
        }
    }
    state_entry(){
        if(llGetObjectName()=="[Xenhat] Enhanced Kemono Updater"){return;}

string self=llGetScriptName();string basename=self;string tail = "MISSING_VERSION";if(llSubStringIndex(self," ") >= 0){integer start=2;
tail=llGetSubString(self,llStringLength(self) - start,-1);while(llGetSubString(tail,0,0)!=" ")
{start++;tail=llGetSubString(self,llStringLength(self) - start,-1);}if((integer)tail > 0){
basename=llGetSubString(self,0,-llStringLength(tail) - 1);}}integer n=llGetInventoryNumber(INVENTORY_SCRIPT);
while(n-- > 0){string item=llGetInventoryName(INVENTORY_SCRIPT,n);
if(item != self && 0 == llSubStringIndex(item,basename)){llRemoveInventory(item);llOwnerSay("Upgraded to "+ tail);}}
        g_Owner_k=llGetOwner();

        g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"
            + "XenHat/"+ "Kemono-Body-Script"
            +"/releases/latest?access_token="
            +"603ee815cda6fb45fcc16876effbda017f158bef",
            [HTTP_BODY_MAXLENGTH,16384],"");
        integer part=llGetNumberOfPrims();
        integer found_fitted_torso = FALSE;
        for (;part > 0;--part){
            string name=llGetLinkName(part);
            if(!found_fitted_torso){
                if(name ==  "Fitted Torso Old Root" ){

                    found_fitted_torso = TRUE;
                    name= "Fitted Kemono Torso" ;
                }
                else if(llSubStringIndex(name, "Kemono")!=-1 &&
                    llSubStringIndex(name, "Torso")!=-1 &&
                    (llSubStringIndex(name, "Petite")!=-1 ||
                    llSubStringIndex(name, "Busty")!=-1)){





                    found_fitted_torso = TRUE;
                    llSetLinkPrimitiveParams(part, [PRIM_NAME, "Fitted Torso Old Root" ]);
                    name= "Fitted Kemono Torso" ;
                }
            }
            if(llListFindList( ["BitState0","BitState1","BitState2","BitState3","cumButtS1","cumButtS2","cumButtS3", "arms" , "body" , "Fitted Kemono Torso" , "TorsoChest" , "TorsoEtc" , "HumanLegs" , "NipState0" , "NipState1" , "NipAlpha" , "handL" , "handR" , "hips" , "LFleg" , "LHleg" , "RFleg" , "RHleg" , "neck" , "PG" , "Kemono - Body" ] ,[name])!=-1){
                g_LinkDB_l+=[name,part];
            }
        }
        if(found_fitted_torso){
            g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings | 1 ) ;
        }
            g_AnimDeform=llGetInventoryName(INVENTORY_ANIMATION,0);
            g_AnimUndeform=llGetInventoryName(INVENTORY_ANIMATION,1);
        list data = llCSV2List(llGetObjectDesc());
        human_mode = llList2Integer(data,0);
        if(llListFindList(g_LinkDB_l,[ "LFleg" ]) == -1 && llListFindList(g_LinkDB_l,[ "RFleg" ]) == -1){

            g_LastCommand_s="Hlegs";
            xlProcessCommandWrapper();
            llOwnerSay("Adjusted for missing animal legs");
        }
        else if(llListFindList(g_LinkDB_l,[ "LHleg" ]) == -1 && llListFindList(g_LinkDB_l,[ "RHleg" ]) == -1){

            g_LastCommand_s="Flegs";
            xlProcessCommandWrapper();
            llOwnerSay("Adjusted for missing human legs");
        }
        if(llGetAttached()){
            llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
        }
        llSetText("",ZERO_VECTOR,0.0);
        llListen( -34525475 ,"","","");
        llSetObjectDesc((string)(human_mode) + "," +  "0.3.22" );
    }
    listen(integer channel,string name,key id,string message){
        key object_owner_k=llGetOwnerKey(id);
        g_LastCommand_s = message;
        integer separatorIndex=llSubStringIndex(g_LastCommand_s,":");
        string first_command = llGetSubString(g_LastCommand_s, 0, separatorIndex-1);
        if(object_owner_k == g_Owner_k){
            if(first_command=="add"){
                if(llGetFreeMemory() > 2048){
                    if(llListFindList(g_AttmntAuthedKeys_l,[id])==-1)
                    {
                        g_AttmntAuthedKeys_l +=[id];
                    }
                }
            }
            else


            xlProcessCommandWrapper();
        }
        else{
            if(first_command=="remove"){
                integer placeinlist=llListFindList(g_AttmntAuthedKeys_l,[(key)id]);
                if(placeinlist !=-1){
                    g_AttmntAuthedKeys_l=llDeleteSubList(g_AttmntAuthedKeys_l,
                        placeinlist,placeinlist);
                }
                return;
            }
            else
            {
                    if(llListFindList(g_AttmntAuthedKeys_l,[id]) > -1){
                        jump AUTHORIZED;
                    }
                    else
                    {
                    }

                    return;

                    @AUTHORIZED;
                    xlProcessCommandWrapper();
            }
        }
    }
    on_rez(integer p){

        llSleep(3);
        llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);

        g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"
            + "XenHat/"+ "Kemono-Body-Script"
            +"/releases/latest?access_token="
            +"603ee815cda6fb45fcc16876effbda017f158bef",
            [HTTP_BODY_MAXLENGTH,16384],"");

    }

    attach(key id){
        if(llGetObjectName()=="[Xenhat] Enhanced Kemono Updater"){return;}
        if(id==NULL_KEY){
        }
        else{
            llStopAnimation(g_AnimUndeform);
            llSleep(0.1);
            llStartAnimation(g_AnimDeform);
        }
    }

    run_time_permissions(integer perm){
        if(!g_HasAnimPerms){
            resetHands();
        }
        g_HasAnimPerms=TRUE;
        llSetTimerEvent(5);
    }
    timer(){

        if(llGetAttached()){
            if(!g_HasAnimPerms){
                llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
            }
            else{
                redeform();
            }
        }
    }
    http_response(key request_id,integer status,list metadata,string body)
    {
        if(request_id !=g_internal_httprid_k) return;
        g_internal_httprid_k=NULL_KEY;
        string new_version_s=llJsonGetValue(body,["tag_name"]);
        if(new_version_s== "0.3.22" ) return;
        list cur_version_l=llParseString2List( "0.3.22" ,["."],[""]);
        list new_version_l=llParseString2List(new_version_s,["."],[""]);

        if(llList2Integer(new_version_l,0) > llList2Integer(cur_version_l,0)){
            jump update;
        }

        else if(llList2Integer(new_version_l,1) >
            llList2Integer(cur_version_l,1)){
            jump update;
        }

        else if(llList2Integer(new_version_l,2) >
            llList2Integer(cur_version_l,2)){
            jump update;
        }
        return;
        @update;
        string update_title=llJsonGetValue(body,["name"]);
        if(update_title=="﷕")update_title="";
        else update_title="\n\n"+update_title;
        string update_description=llJsonGetValue(body,["body"]);
        if(update_description=="﷕"){
            update_description="";
        }
        update_description+="\n";
        if(llStringLength(update_description) >=350)
        update_description="Too many changes, see ["+"https://github.com/"+ "XenHat/"+ "Kemono-Body-Script"
        +"/compare/"+ "0.3.22" +"..."+new_version_s+" Changes for "
        + "0.3.22" +"↛"+new_version_s+"]\n";
        string g_cached_updateMsg_s="\nAn update is available!"+update_title+"\n"+update_description+"\n"
        +"Your new script:\n[https://raw.githubusercontent.com/"
        + "XenHat/"+ "Kemono-Body-Script" +"/"+new_version_s+"/compiled/"+ "xenhat.kemono.body.lsl" +" "
        + "Kemono-Body-Script" +".lsl]";
        llDialog(g_Owner_k, "Kemono-Body-Script"  + " v"+ "0.3.22"  +"\n"+g_cached_updateMsg_s,["Close"],-1);
    }

}

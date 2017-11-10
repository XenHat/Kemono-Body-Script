float g_Config_MaximumOpacity=1.00;
integer g_CurrentFittedButState=1;
integer g_CurrentFittedNipState=1;
integer g_CurrentFittedVagState=1;
integer g_HasAnimPerms=FALSE;
integer g_RuntimeBodyStateSettings;
integer g_TogglingPGMeshes=FALSE;
integer human_mode=TRUE;

key g_internal_httprid_k=NULL_KEY;

key g_Owner_k;
list g_LinkDB_l=[];
list g_RemConfirmKeys_l;
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
            if(human_mode)
                return [1];
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
            return [llList2String( [ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] , g_CurrentFittedNipState)];
        return [ "PG" ];
    }
    else if(name== "vagoo" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            if(g_TogglingPGMeshes)
                return [llList2String( ["BitState0","BitState1","BitState2","BitState3"] , 0)];
            return [llList2String( ["BitState0","BitState1","BitState2","BitState3"] , g_CurrentFittedVagState)];
        return [ "PG" ];
    }
    else if(name== "thighLR" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            if(human_mode)
                return [ "HumanLegs" ];
            return [ "TorsoEtc" ];
        if(human_mode)
            return [ "RHleg" ];
        return [ "RFleg" ];
    }
    else if(name== "thighLL" ){
        if( (!!(g_RuntimeBodyStateSettings & 1 )) )
            if(human_mode)
               return [ "HumanLegs" ];
            return [ "TorsoEtc" ];
        if(human_mode)
            return [ "LHleg" ];
        return [ "LFleg" ];
    }
    return [name];
}
list xlSetGenitals(integer pTogglePart){
    list params;
    integer meshes_count=0;
    if( 16 ==pTogglePart)
        meshes_count= (( [ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] !=[])-1) ;
    else
        meshes_count= (( ["BitState0","BitState1","BitState2","BitState3"] !=[])-1) ;
    integer visible=FALSE;
    string mesh_name="";
    for(;meshes_count > -1;meshes_count--){

        if( 16 ==pTogglePart)
            visible=! (!!(g_RuntimeBodyStateSettings & pTogglePart))  * (meshes_count==g_CurrentFittedNipState);
        else if( 32 ==pTogglePart)
            visible=! (!!(g_RuntimeBodyStateSettings & pTogglePart))  * (meshes_count==g_CurrentFittedVagState);
        else if( 8 ==pTogglePart)
            visible=! (!!(g_RuntimeBodyStateSettings & pTogglePart))  * (meshes_count==g_CurrentFittedButState);
        if( 16 ==pTogglePart)
            mesh_name=llList2String( [ "NipState0" , "TorsoEtc" , "NipState1" , "NipAlpha" ] ,meshes_count);
        else
            mesh_name=llList2String( ["BitState0","BitState1","BitState2","BitState3"] ,meshes_count);
        list prim_names=xlBladeNameToPrimNames(mesh_name);
        integer prim_count= ((prim_names!=[])-1) ;
        for(;prim_count> -1;prim_count--){
            integer link_id=llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[llList2String(prim_names,prim_count)])+1);
            params +=[PRIM_LINK_TARGET,link_id];
            list faces_l=[];
            if( 16 ==pTogglePart)
                faces_l=xlGetFacesByBladeName( "nips" );
            else if( 32 ==pTogglePart)
                faces_l=xlGetFacesByBladeName( "vagoo" );
            else if( 8 ==pTogglePart)
                faces_l=xlGetFacesByBladeName( "butt" );
            integer faces_count= ((faces_l!=[])-1) ;
            for(;faces_count > -1;--faces_count)
                params+=[PRIM_COLOR,llList2Integer(faces_l,faces_count), <1,1,1>, visible * g_Config_MaximumOpacity];
        }
    }
    return params;
}
xlProcessCommand(string message){
    list data=llParseStringKeepNulls(message,[":"],[]);
    string command=llList2String(data,0);
    integer showit;

    if(command=="show")
        showit=TRUE;
    else if(command=="hide")
        showit=FALSE;
    else if( (!!(g_RuntimeBodyStateSettings & 1 )) )
        if(command=="setbutt"){
            g_CurrentFittedButState=llList2Integer(data,1);
            llSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals( 8 )) ;
        }
        else if(command=="setvag"){
            g_CurrentFittedVagState=llList2Integer(data,1);
            llSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals( 32 )) ;
        }
        else if(command=="setnip"){
            g_CurrentFittedNipState=llList2Integer(data,1);
            llSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals( 16 )) ;
        }
        else
            return;
    else
        return;
    string part_wanted_s=llList2String(data, 1);
    if(part_wanted_s== "nips"  &&  (!!(g_RuntimeBodyStateSettings & 1 )) ){
        g_CurrentFittedNipState=showit;
        llSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals( 16 )) ;
        return;
    }
    else if(part_wanted_s== "vagoo"  &&  (!!(g_RuntimeBodyStateSettings & 1 )) ){
        g_CurrentFittedVagState=showit;
        g_TogglingPGMeshes=TRUE;
        llSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals( 32 )) ;
        g_TogglingPGMeshes=FALSE;
        return;
    }
    else if(part_wanted_s== "vagoo" ){
        g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 2 )) | ( 2  * !showit);






    }
    else if(part_wanted_s== "nips" ){

        g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 4 )) | ( 4  * !showit);





    }
    integer list_size= ((data!=[])-1) ;
    list params;
    for(;list_size > 0;list_size--){

        string blade_name=llList2String(data, list_size);
        list params_internal;
        if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
            if(blade_name== "breast" ){
                g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 16 )) | ( 16 * !showit); ;
                params_internal +=xlSetGenitals( 16 );
            }
            else if(blade_name== "pelvis" ){
                g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings & (~ 32 )) | ( 32 * !showit); ;
                params_internal +=xlSetGenitals( 32 );
            }
        }
        else{

            if(blade_name== "pelvis" ){

                showit *=!(g_RuntimeBodyStateSettings &  2 );
                xlProcessCommand( "vagoo" );
            }
            else if(blade_name== "breast" ){


                if(!(g_RuntimeBodyStateSettings &  4 ) && !showit)
                    xlProcessCommand("hide:"+ "nips" );

                else
                    xlProcessCommand("show:"+ "nips" );
            }
        }
        list prim_names=xlBladeNameToPrimNames(blade_name);
        integer blade_prim_iter= ((prim_names!=[])-1) ;
        for(;blade_prim_iter > -1;blade_prim_iter--){
            params_internal+=[PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[llList2String(prim_names,blade_prim_iter)])+1)];
            list faces_l=xlGetFacesByBladeName(blade_name);
            integer faces_index= ((faces_l!=[])-1) ;
            for(;faces_index > -1; faces_index--)
                params_internal+=[PRIM_COLOR, llList2Integer(faces_l,faces_index), <1,1,1>, (showit ^ ( "vagoo" ==blade_name)) * g_Config_MaximumOpacity];
        }
    params+=params_internal;
    }
    llSetLinkPrimitiveParamsFast(LINK_SET,params) ;
}
default {
    changed(integer change){
        if(change & CHANGED_OWNER)
            llResetScript();
        else if(change & CHANGED_LINK)
            llResetScript();
    }
    state_entry(){
        g_Owner_k=llGetOwner();
        integer part=llGetNumberOfPrims();
        for (;part > 0;--part){
            string name=llGetLinkName(part);
            if(! (!!(g_RuntimeBodyStateSettings & 1 )) ){

                integer fitted_torso_string_index=llSubStringIndex(name,  "Fitted Kemono Torso" );
                if(fitted_torso_string_index > 5)
                    if(fitted_torso_string_index < 8){
                        g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings | 1 ) ;
                        name= "Fitted Kemono Torso" ;
                    }
            }
            if(llListFindList( ["BitState0","BitState1","BitState2","BitState3","cumButtS1","cumButtS2","cumButtS3", "arms" , "body" , "Fitted Kemono Torso" , "TorsoChest" , "TorsoEtc" , "HumanLegs" , "NipState0" , "NipState1" , "NipAlpha" , "handL" , "handR" , "hips" , "LFleg" , "LHleg" , "RFleg" , "RHleg" , "neck" , "PG" , "Kemono - Body" ] , [name])!=-1){
                g_LinkDB_l+=[name,part];
            }
        }
        g_AnimDeform=llGetInventoryName(INVENTORY_ANIMATION, 0);
        g_AnimUndeform=llGetInventoryName(INVENTORY_ANIMATION, 1);
        if(llGetAttached())
            llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
        else
            llSetTimerEvent(0.1);
        llSetText("",ZERO_VECTOR,0.0);
        llListen( -34525475 ,"","","");
    }
    listen(integer channel, string name, key id, string message){
        key owner_key=llGetOwnerKey(id);
        if(owner_key==id){

            if(llListFindList(g_RemConfirmKeys_l,[id])==-1)
                return;
        }

        else if(owner_key !=g_Owner_k)
            return;
        if("reqFTData"==message){
            if( (!!(g_RuntimeBodyStateSettings & 1 )) ){
                llWhisper( -34525475 ,"resFTdat:nipState:"
                    +(string)g_CurrentFittedNipState
                    +":nipAlpha:0"
                    +":nipOvrd:0"
                    +":vagState:"+(string)g_CurrentFittedVagState
                    +":buttState:"+(string)g_CurrentFittedButState
                    +":humLegs:"+(string)human_mode);
            }
            return;
        }

        else if(message=="add"){
            if(llGetFreeMemory() > 2048)
                if(llListFindList(g_RemConfirmKeys_l,[id])==-1)
                    g_RemConfirmKeys_l +=[id];
        }
        else if(message=="remove"){
            integer placeinlist=llListFindList(g_RemConfirmKeys_l, [(key)id]);
            if(placeinlist !=-1)
                g_RemConfirmKeys_l=llDeleteSubList(g_RemConfirmKeys_l, placeinlist, placeinlist);
            return;
        }
        else if(message=="Hlegs"){
            if(!human_mode){
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=TRUE;
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            }
        }
        else if(message=="Flegs"){
            if(human_mode){
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=FALSE;
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            }
        }

        else if(message=="resetA")
            jump reset;
        else if(message=="resetB"){
            g_RemConfirmKeys_l=[];
            jump reset;
        }
        else
            xlProcessCommand(message);
        return;
        @reset;
        xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
    }
    on_rez(integer p){
        llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);

        g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"+ "XenHat/"+ "Kemono-Body-Script" +"/releases/latest?access_token=603ee815cda6fb45fcc16876effbda017f158bef",[HTTP_BODY_MAXLENGTH, 16384], "");

    }
    attach(key id){
        if(id==(key)NULL_KEY)
        llStartAnimation(g_AnimUndeform);
    }
    run_time_permissions(integer perm){
        g_HasAnimPerms=TRUE;

        llWhisper( -34525475 ,"show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        llSetTimerEvent(0.1);
    }
    timer(){
        if(llGetAttached()){
            if(!g_HasAnimPerms)
                llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
            else
                llStartAnimation(g_AnimDeform);
        }
        string text;
        llSetText(text+"\n \n \n \n ",  <0.925,0.925,0.925> ,  0.75 );
        llSetTimerEvent(10);
    }

    http_response(key request_id, integer status, list metadata, string body)
    {
        if(request_id !=g_internal_httprid_k) return;
        g_internal_httprid_k=NULL_KEY;
        string new_version_s=llJsonGetValue(body,["tag_name"]);
        if(new_version_s== "0.1.4" ) return;
        list cur_version_l=llParseString2List( "0.1.4" , ["."], [""]);
        list new_version_l=llParseString2List(new_version_s, ["."], [""]);
        string update_type="version";
        if(llList2Integer(new_version_l, 0) > llList2Integer(cur_version_l, 0)){
            update_type="major version"; jump update;
        }
        else if(llList2Integer(new_version_l, 1) > llList2Integer(cur_version_l, 1)){
            update_type="version"; jump update;
        }
        else if(llList2Integer(new_version_l, 2) > llList2Integer(cur_version_l, 2)){
            update_type="patch"; jump update;
        }
        jump end;
        @update;
        string sHelpText="[https://github.com/"+ "XenHat/"+ "Kemono-Body-Script"  +" "+ "Kemono-Body-Script"  +"] v"
       + "0.1.4" +" by secondlife:///app/agent/f1a73716-4ad2-4548-9f0e-634c7a98fe86/inspect.\n";
        string update_title=llJsonGetValue(body,["name"]);
        if(update_title=="﷕")
            update_title="";
        else update_title=":\n\n"+update_title;
        string update_description=llJsonGetValue(body,["body"]);
        if(update_description=="﷕")
            update_description="";
        else update_description+="\n";
        if(llStringLength(update_description) >=128)
            update_description="Too many changes, see link below.";
        string g_cached_updateMsg_s="A new "+update_type+" (v"+new_version_s +") is available!"
            +update_title+"\n";
            g_cached_updateMsg_s +=update_description+"\n"
            +"Your new scripts (["+"https://github.com/"+ "XenHat/"+ "Kemono-Body-Script" +"/compare/"
                + "0.1.4" +"..."+new_version_s+" Diff "+ "0.1.4" +"..."+new_version_s+"]):\n[https://raw.githubusercontent.com/"+ "XenHat/"+ "Kemono-Body-Script"
                +"/"+new_version_s+"/compiled/"+ "xenhat.kemono.body.lsl" +" "+ "Kemono-Body-Script" +".lsl]";
        llDialog(g_Owner_k,sHelpText+g_cached_updateMsg_s,["Close"],-1);
        @end;
    }

}

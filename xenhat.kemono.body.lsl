/*<<<-------------------------Enlarge window so you see this on only one line for better visibility ------------------>>>>>*/
/* Aftermarket Kemono Body Script Replacement by Xenhat Liamano @ Second Life

Licensed under the Aladdin Free Public License Version 9 
For the Full license, see https://ghostscript.com/doc/8.54/Public.htm

The short human readable version of this licence for the befit of the reader is:

You CAN:
 Modify 
 Distribute 

You CANNOT:
 Hold Liable 
 Sublicense 
 Place Warranty 
 Commercial Use 

You MUST:
 Include License 
 Include Original 
 State Changes 

An online version of the human-readable version of the AFPL can be found at:
https://tldrlegal.com/license/aladdin-free-public-license
*/

/* SCRIPT BEGINS HERE */
/* Runtime User Config starts here */
float g_Config_MaximumOpacity = 1.0; // 0.8 // for goo
/* Runtime User Config ends here */
/* Defines */
// #define DEBUG
// #define DEBUG_LISTEN
// #define DEBUG_PARAMS
// #define DEBUG_FACE_SELECT
// #define DEBUG_LISTEN_PROCESS
// #define DEBUG_WHO
// #define AUTH_ANYWAY
// #define DEBUG_MEMORY
// End of debug defines
#ifdef DEBUG_PARAMS
#define xlSetLinkPrimitiveParamsFast(a,b) llOwnerSay("LINK:"+(string)a+"\nPARAMS:"+llList2CSV(b));llSetLinkPrimitiveParamsFast(a,b)
#else
#define xlSetLinkPrimitiveParamsFast(a,b) llSetLinkPrimitiveParamsFast(a,b)
#endif
/* TODO:
    - Stock kemono nipples sync
    - Fitted Torso vagina PG mode
    - Human/Animal mode toggle
*/
#define KEMONO_COM_CH -34525475
#define MESH_ARMS "arms"
#define MESH_BODY "body"
#define MESH_HAND_LEFT "handL"
#define MESH_HAND_RIGHT "handR"
#define MESH_HIPS "hips"
#define MESH_LEG_LEFT_ANIMAL "LFleg"
#define MESH_LEG_LEFT_HUMAN "LHleg"
#define MESH_LEG_RIGHT_ANIMAL "RFleg"
#define MESH_LEG_RIGHT_HUMAN "RHleg"
#define MESH_NECK "neck"
#define MESH_PG_LAYER "PG"
#define MESH_ROOT "Kemono - Body"
#define MESH_FITTED_TORSO "Fitted Kemono Torso"
#define BLADE_ABS "abs"
#define BLADE_ANKLE_L "ankleL"
#define BLADE_ANKLE_R "ankleR"
#define BLADE_ARM_L_L "armLL"
#define BLADE_ARM_L_R "armLR"
#define BLADE_ARM_U_L "armUL"
#define BLADE_ARM_U_R "armUR"
#define BLADE_BELLY "belly"
#define BLADE_BODY "body"
#define BLADE_BREASTS "breast"
#define BLADE_CALF_L "calfL"
#define BLADE_CALF_R "calfR"
#define BLADE_CHEST "chest"
#define BLADE_COLLAR "collar"
#define BLADE_ELBOW_L "elbowL"
#define BLADE_ELBOW_R "elbowR"
#define BLADE_FITTED_TORSO "Fitted Torso"
#define BLADE_HAND_LEFT "handL"
#define BLADE_HAND_RIGHT "handR"
#define BLADE_HIP_L "hipL"
#define BLADE_HIP_R "hipR"
#define BLADE_KNEE_L "kneeL"
#define BLADE_KNEE_R "kneeR"
#define BLADE_LEG_LEFT_ANIMAL "LFleg"
#define BLADE_LEG_LEFT_HUMAN "LHleg"
#define BLADE_LEG_RIGHT_ANIMAL "RFleg"
#define BLADE_LEG_RIGHT_HUMAN "RHleg"
#define BLADE_NECK "neck"
#define BLADE_NIPS "nips"
#define BLADE_PELVIS "pelvis"
#define BLADE_PG_LAYER "PG"
#define BLADE_RIBS "ribs"
#define BLADE_SHIN_L_L "shinLL"
#define BLADE_SHIN_L_R "shinLR"
#define BLADE_SHIN_U_L "shinUL"
#define BLADE_SHIN_U_R "shinUR"
#define BLADE_SHOULDER_L_L "shoulderLL"
#define BLADE_SHOULDER_L_R "shoulderLR"
#define BLADE_SHOULDER_U_L "shoulderUL"
#define BLADE_SHOULDER_U_R "shoulderUR"
#define BLADE_THIGH_L_L "thighLL"
#define BLADE_THIGH_L_R "thighLR"
#define BLADE_THIGH_U_L "thighUL"
#define BLADE_THIGH_U_R "thighUR"
#define BLADE_VAG "vagoo"
#define BLADE_WRIST_L "wristL"
#define BLADE_WRIST_R "wristR"
#define BLADE_FOOT_R "footR"
#define BLADE_FOOT_L "footL"
integer g_State_PG = TRUE;
integer FITTED_COMBO = FALSE;
key g_Owner_k;
list g_RemConfirmKeys_l;
list g_LinkDB_l = [];
integer g_CurrentFittedBitState=1;
integer g_CurrentFittedNipState=0;
list s_FittedVagooState=["BitState0","BitState1", "BitState2", "BitState3"];
/* NipAlpha unused with Kemono API; requires Starbright hud, which is a job for later*/
list s_FittedNipsState=["NipState0","NipAlpha","NipState1"];
// list s_FittedNipsState=["NipState0","NipState1"];
// Fitted Kemono Bits Add-On by Starbright (unimplemented ATM)
// list s_FittedCumLayers_Butt=["cumButtS1","cumButtS2","cumButtS3"];
/* 
PG ON:
    NipState0 = VISIBLE
    TorsoEtc;face_list=[0,1] = INVISIBLE
*/
xlSafeGenitalToggle(string name,integer showit)
{
    integer link_id;
    if(FITTED_COMBO)
    {
        
        if (name==BLADE_NIPS)
        {
            if(!showit)
            {
                g_State_PG=TRUE;
            }
            else
            {
                g_State_PG = FALSE;
            }
        }
        // llWhisper(DEBUG_CHANNEL, "HIDEBLADE:" + (string)(name==BLADE_BREASTS));
        if (name==BLADE_NIPS||name==BLADE_BREASTS)
        {
            float showit_alpha = (name==BLADE_NIPS) * !showit * g_Config_MaximumOpacity;
            // Note: My attempts at inlining these into a macro resulted in garbage code.
            integer wat = llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,["TorsoEtc"])+1);
            list wet = [
                PRIM_COLOR,0,<1,1,1>,showit * g_Config_MaximumOpacity
                ,PRIM_COLOR,1,<1,1,1>,showit * g_Config_MaximumOpacity
                ,PRIM_LINK_TARGET,(integer)llList2String(g_LinkDB_l,(integer)llListFindList(g_LinkDB_l,["NipState0"])+1),PRIM_COLOR,ALL_SIDES,<1,1,1>,showit_alpha
                ,PRIM_LINK_TARGET,(integer)llList2String(g_LinkDB_l,(integer)llListFindList(g_LinkDB_l,["NipAlpha"])+1),PRIM_COLOR,ALL_SIDES,<1,1,1>,0
                ,PRIM_LINK_TARGET,(integer)llList2String(g_LinkDB_l,(integer)llListFindList(g_LinkDB_l,["NipState1"])+1),PRIM_COLOR,ALL_SIDES,<1,1,1>,0
                ];
            xlSetLinkPrimitiveParamsFast(wat,wet);
        }
    }
    else
    {
        llOwnerSay("unimplemented!");
    }
}
integer xlGetLinkByBladeName(string name)
{
    #ifdef DEBUG
    integer index = llListFindList(g_LinkDB_l,[xlGetPrimNameByBladeName(name)]);
    integer id = llList2Integer(g_LinkDB_l,index+1);
    llOwnerSay("Wanted:"+name+"\n"+
    "Index: :"+(string)index+"\n"+
    "Returning ID:"+(string)id+"\n"+
    "List:"+llList2CSV(g_LinkDB_l));
    return id;
    #else
        return llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[xlGetPrimNameByBladeName(name)])+1);
    #endif
}
integer human_mode = TRUE;
list xlGetFacesByBladeName(string name)
{
    if(name==BLADE_ABS)return [6,7];
    if(name==BLADE_ANKLE_L)return [1];
    if(name==BLADE_ANKLE_R)return [1];
    if(name==BLADE_ARM_L_L)return [7];
    if(name==BLADE_ARM_L_R)return [2];
    if(name==BLADE_ARM_U_L)return [0];
    if(name==BLADE_ARM_U_R)return [6];
    if(name==BLADE_BELLY)return [2,3];
    if(name==BLADE_BODY)return [0];
    if(name==BLADE_BREASTS){
        if(FITTED_COMBO) return [2,3];
        return [2,5];
    }
    if(name==BLADE_CALF_L)return [4];
    if(name==BLADE_CALF_R)return [4];
    if(name==BLADE_CHEST){
        if(FITTED_COMBO) return [0,1];
        return [0,4];
    }
    if(name==BLADE_COLLAR){
        if(FITTED_COMBO) return [6,7];
        return [1,6];
    }
    if(name==BLADE_ELBOW_L)return [4];
    if(name==BLADE_ELBOW_R)return [5];
    if(name==BLADE_FOOT_L)return [0];
    if(name==BLADE_FOOT_R)return [0];
    if(name==BLADE_HIP_L){
        if(FITTED_COMBO)return [5];
        return [6];
    }
    if(name==BLADE_HIP_R){
        if(FITTED_COMBO)return [4];
        return [5];
    }
    if(name==BLADE_KNEE_L)return [5];
    if(name==BLADE_KNEE_R)return [5];
    if(name==BLADE_HAND_LEFT)return [-1];
    if(name==BLADE_HAND_RIGHT)return [-1];
    if(name==BLADE_NECK){
        if(FITTED_COMBO) return [0,1];
        return [2,5];
    }
    if(name==BLADE_NIPS)return [2,3];
    if(name==BLADE_PELVIS){
        if(FITTED_COMBO) return [0,1,2,3];
        return [0,1];
    }
    if(name==BLADE_RIBS){
        if(FITTED_COMBO) return [4,5];
        return [1,3];
    }
    if(name==BLADE_SHIN_L_L)return [2];
    if(name==BLADE_SHIN_L_R)return [2];
    if(name==BLADE_SHIN_U_L)return [3];
    if(name==BLADE_SHIN_U_R)return [3];
    if(name==BLADE_SHOULDER_L_L)return [3];
    if(name==BLADE_SHOULDER_L_R){
        if(FITTED_COMBO) return [2];
        return [0];
    }
    if(name==BLADE_SHOULDER_U_L){
        if(FITTED_COMBO) return [5];
        return [7];
    }
    if(name==BLADE_SHOULDER_U_R)return [4];
    if(name==BLADE_THIGH_L_L){
        if(FITTED_COMBO)
        {
            return [7];
        }
        if(human_mode){
            return [6];
        }
        else {
            return [];
        }
    }
    if(name==BLADE_THIGH_L_R){
        if(FITTED_COMBO)
        {
            return [6];
        }
        if(human_mode){
            return [6];
        }
        else {
            return [];
        }
    }
    if(name==BLADE_THIGH_U_L){
        if(FITTED_COMBO)return [5];
        return [7];
    }
    if(name==BLADE_THIGH_U_R)return [4];
    if(name==BLADE_VAG)return [0,1];
    if(name==BLADE_WRIST_L)return [3];
    if(name==BLADE_WRIST_R)return [1];
    return [];
}
string xlGetPrimNameByBladeName(string name)
{
    if(name==BLADE_ABS) jump mesh_body;
    if(name==BLADE_ANKLE_L) jump mesh_knee_l;
    if(name==BLADE_ANKLE_R) jump mesh_knee_r;
    if(name==BLADE_ARM_L_L) jump mesh_arms;
    if(name==BLADE_ARM_L_R) jump mesh_arms;
    if(name==BLADE_ARM_U_L) jump mesh_arms;
    if(name==BLADE_ARM_U_R) jump mesh_arms;
    if(name==BLADE_BELLY) jump mesh_hips;
    if(name==BLADE_BODY) jump mesh_body;
    if(name==BLADE_BREASTS)jump mesh_body;
    if(name==BLADE_CALF_L) jump mesh_knee_l;
    if(name==BLADE_CALF_R) jump mesh_knee_r;
    if(name==BLADE_CHEST)jump mesh_body;
    if(name==BLADE_COLLAR) jump mesh_neck;
    if(name==BLADE_ELBOW_L) jump mesh_arms;
    if(name==BLADE_ELBOW_R) jump mesh_arms;
    if(name==BLADE_FOOT_L) jump mesh_knee_l;
    if(name==BLADE_FOOT_R) jump mesh_knee_r;
    if(name==BLADE_HAND_LEFT) jump mesh_hand_l;
    if(name==BLADE_HAND_RIGHT) jump mesh_hand_r;
    if(name==BLADE_HIP_L || name==BLADE_HIP_R){
        if(FITTED_COMBO)
        {
            return llList2String(s_FittedVagooState,g_CurrentFittedBitState);
        }
        jump mesh_hips;
    }
    if(name==BLADE_KNEE_L) jump mesh_knee_l;
    if(name==BLADE_KNEE_R) jump mesh_knee_r;
    if(name==BLADE_NECK) jump mesh_neck;
    if(name==BLADE_NIPS) jump mesh_pg;
    if(name==BLADE_PELVIS){
        if(FITTED_COMBO)
        {
            return llList2String(s_FittedVagooState,g_CurrentFittedBitState);
        }
        jump mesh_hips;
    }
    if(name==BLADE_RIBS)jump mesh_body;
    if(name==BLADE_SHIN_L_L) jump mesh_knee_l;
    if(name==BLADE_SHIN_L_R) jump mesh_knee_r;
    if(name==BLADE_SHIN_U_L) jump mesh_knee_l;
    if(name==BLADE_SHIN_U_R) jump mesh_knee_r;
    if(name==BLADE_SHOULDER_L_L) jump mesh_neck;
    if(name==BLADE_SHOULDER_L_R) jump mesh_neck;
    if(name==BLADE_SHOULDER_U_L) jump mesh_neck;
    if(name==BLADE_SHOULDER_U_R) jump mesh_neck;
    if(name==BLADE_THIGH_U_L) jump mesh_hips;
    if(name==BLADE_THIGH_U_R) jump mesh_hips;
    if(name==BLADE_VAG) jump mesh_pg;
    if(name==BLADE_WRIST_L) jump mesh_arms;
    if(name==BLADE_WRIST_R) jump mesh_arms;
    /* TODO: Human/Animal mode toggle*/
    if(name==BLADE_THIGH_L_R)jump mesh_leg_r;
    if(name==BLADE_THIGH_L_L)jump mesh_leg_l;

    @mesh_pg;
    return MESH_PG_LAYER;
    @mesh_neck;
    if(FITTED_COMBO) return MESH_FITTED_TORSO;
    return MESH_NECK;
    @mesh_arms;
    return MESH_ARMS;
    @mesh_hand_l;
    return MESH_HAND_LEFT;
    @mesh_hand_r;
    return MESH_HAND_RIGHT;
    @mesh_leg_r;
    if(FITTED_COMBO)
    {
        return "TorsoEtc";
    }
    @mesh_knee_r;
    return MESH_LEG_RIGHT_HUMAN;
    @mesh_leg_l;
    if(FITTED_COMBO)
    {
        return "TorsoEtc";
    }
    @mesh_knee_l;
    return MESH_LEG_LEFT_HUMAN;
    @mesh_hips;
    if(FITTED_COMBO) return "TorsoEtc";
    return MESH_HIPS;
    @mesh_body;
    if(FITTED_COMBO)
    {
        return "TorsoChest";
    }
    return MESH_BODY;
    // Fallback
    //return name;
}
xlProcessCommand(string message)
{
    list data = llParseStringKeepNulls(message,[":"],[]);
    integer showit;
    string command = llList2String(data,0);
    if(command == "show"){
        showit = TRUE;
    }
    else if(command == "hide"){
        showit = FALSE;
    }
    else
    {
        return;
    }
    command="";
    /* Straight up ignore the Fitted Torso's generic "fix body" command */
    // if(FITTED_COMBO)
    {
        // if (message=="hide:neck:shoulderLR:shoulderLL:shoulderUR:shoulderUL:collar:chest:breast:ribs:abs:belly:pelvis:hipR:hipL:thighUR:thighUL:thighLR:thighLL");
        // return;
    }
    integer part_in = llGetListLength(data) - 1;
    list params;
    for(;part_in >= 1; --part_in) /* skip first element*/
    {
        /* When linked against the Fitted Torso, we need to skip the parts handled by said torso
        *  to avoid endless toggling as the fitted torso requests hiding of the faces it replaces
        * to "fix" the stock body
        */
        string part_wanted_s = llList2String(data, part_in);
        if(part_wanted_s==BLADE_NIPS || part_wanted_s==BLADE_BREASTS)
        {
            if(FITTED_COMBO)
            {
               xlSafeGenitalToggle(part_wanted_s,showit);
            }
            // if(part_wanted_s==
        }
        //else NO.
        {
            // TODO: Write a better handling of this because we need to handle genitals
            // very carefully
            list faces_l = xlGetFacesByBladeName(part_wanted_s);
            integer link_id = (integer)xlGetLinkByBladeName(part_wanted_s);
            #ifdef DEBUG_FACE_SELECT
            llOwnerSay("Faces List:"+llList2CSV(faces_l));
            llOwnerSay("Link ID  :"+(string)link_id);
            #endif
            integer faces = llGetListLength(faces_l) - 1;
            integer SHOW_WITH_VAGOO = showit ^ (BLADE_VAG==part_wanted_s);
            float SHOW_FOR_REAL = (SHOW_WITH_VAGOO * g_Config_MaximumOpacity);
            params+=[PRIM_LINK_TARGET,link_id];
            for(;faces>=0;--faces) {
                params+=[PRIM_COLOR, llList2Integer(faces_l,faces), <1,1,1>, SHOW_FOR_REAL];
            }
        }
    }
    #ifdef DEBUG_PARAMS
    llOwnerSay("params list:"+llList2CSV(params));
    #endif
    if(params!=[]) {
        llSetLinkPrimitiveParamsFast(LINK_SET, params);
        params=[];
    }
}
default {
    touch_start(integer total_number){
        key tk = llDetectedKey(0);
        if(tk!=g_Owner_k)return;
        llRegionSayTo(tk,0,
            "ID:"+(string)llDetectedLinkNumber(0)+";prim_name=\""+llGetLinkName(llDetectedLinkNumber(0))+"\";face_list=["+(string)llDetectedTouchFace(0)+"];break;");
    }
    changed(integer change) {
        if (change & CHANGED_OWNER) {
            llOwnerSay("The owner of the object has changed, resetting...");
            llResetScript();
        }
        if(change & CHANGED_LINK)
        {
            llResetScript();
        }
    }
    state_entry() {
#ifdef DEBUG_MEMORY
        llScriptProfiler(PROFILE_SCRIPT_MEMORY);
#else
        llScriptProfiler(PROFILE_NONE);
#endif

        llSetText("",<0,0,0>,0.0);
        g_Owner_k = llGetOwner();
        llSetTimerEvent(3);
        #ifdef DEBUG
        llOwnerSay("Counting");
        #endif
        integer part = llGetNumberOfPrims();
        for (; part > 0; --part) {
            string name = llGetLinkName(part);
            if(~llSubStringIndex(name, MESH_FITTED_TORSO))
            {
                /* We are linked with starnya's Fitted Torso*/
                FITTED_COMBO=TRUE;
                name=MESH_FITTED_TORSO;
            }
            g_LinkDB_l+=[name,part];/* Typecast not optional; ensures that llList2* works as intended*/
        }
        #ifdef DEBUG
        llOwnerSay(llList2CSV(g_LinkDB_l));
        #endif
        llSetLinkPrimitiveParamsFast(xlGetLinkByBladeName(BLADE_VAG),[PRIM_TEXTURE,4,TEXTURE_TRANSPARENT,<1,1,0>,<0,0,0>,0.0,
            PRIM_ALPHA_MODE,4,PRIM_ALPHA_MODE_MASK, 1]);
        llListen(KEMONO_COM_CH,"","","");
    }
    listen( integer channel, string name, key id, string message ) {
        key owner_key = llGetOwnerKey(id);
        if (id == llGetKey()) return;
        #ifdef DEBUG_LISTEN
        string knp;
        #ifdef DEBUG_WHO
        knp = "["+(string)id+"]"+"{"+llKey2Name(id)+"}(secondlife:///app/agent/"+(string)llGetOwnerKey(id)+"/inspect) ";
        #endif
        llOwnerSay(knp+"input ["+message+"]");
        #endif
        /* Ignore Starbright's Kemono Torso messages when handling that mesh*/
        if(FITTED_COMBO)
        {
            if(llSubStringIndex(name,MESH_FITTED_TORSO) > 3)
            {
                return;
            }
        }
        /*If we can't get a valid owner...*/
        if(owner_key == id) {
            /*And if they aren't in the auth list, ignore them.*/
            if(llListFindList(g_RemConfirmKeys_l,[id]) == -1) {
                return;
            }
        }
        /*If they don't have the same owner, ignore them.*/
        else if(owner_key != g_Owner_k) {
            return;
        }
        if(message == "add"){
            /*And if they aren't in the auth list, add them.*/
            if(llListFindList(g_RemConfirmKeys_l,[id]) == -1) {
                g_RemConfirmKeys_l += [id];
                return;
            }
        }
        if(message == "remove"){
            /*If the are in the list, remove them.*/
            integer placeinlist = llListFindList(g_RemConfirmKeys_l, [(key)id]);
            if (placeinlist != -1) {
                g_RemConfirmKeys_l = llDeleteSubList(g_RemConfirmKeys_l, placeinlist, placeinlist);
            }
        }
        if (message=="Hlegs"){
            human_mode=FALSE;
            xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            human_mode=TRUE;
            xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
        }
        /* TODO: furry legs toggle*/
        #ifdef FUR_MODE_DONE
        else if(message=="Flegs"){
            human_mode=TRUE;
            xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            human_mode=FALSE;
            xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
        }
        #endif
        /* Restore compatibility with old scripts*/
        else if(message=="resetA"){
            //llOwnerSay("AAAAAAAAAAAAAAAAA");
            xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        }
        else if(message=="resetB"){
            //llOwnerSay("AAAAAAAAAAAAAAAAA");
            xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
            g_RemConfirmKeys_l=[];
        }
        else {
            xlProcessCommand(message);
            #ifdef DEBUG_LISTEN_PROCESS
            llOwnerSay("Sucessfully consumed "+knp+"'s [http://"+message+" command]");
            #endif
        }
    }
    run_time_permissions(integer perm) {
        if (perm & PERMISSION_TRIGGER_ANIMATION) {
            if(llGetAttached()) {
                llStartAnimation("Kem-body-deform");
            }
            else {
                llStopAnimation("Kem-body-deform");
                llStartAnimation("Kem-body-undeform");
                llStopAnimation("Kem-body-undeform");
            }
        }
    }
    timer() {
        if(llGetAttached())llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
#ifdef DEBUG_MEMORY
        llSetText((string)llGetUsedMemory()+"B\n["+(string)llGetSPMaxMemory()+"B]\n-----------\n"+(string)llGetMemoryLimit()+"B\n-----------\n"+(string)llGetListLength(g_RemConfirmKeys_l)+" Keys\nAttached:"+(string)llGetAttached(),<1,1,1>,1.0);
#else
        //if(!llSetMemoryLimit(llGetUsedMemory()+256))
        //{
        //    llOwnerSay("Running out of memory! You should probably mention this to secondlife:///app/agent/f1a73716-4ad2-4548-9f0e-634c7a98fe86/inspect...");
        //}
#endif
    }
}

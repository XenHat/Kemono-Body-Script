/*<<<-------------------------Enlarge window so you see this on only one line for better visibility ------------------>>>>>*/
/* Aftermarket Kemono Body Script Replacement by Xenhat Liamano @ Second Life
Licensed under the Aladdin Free Public License Version 9
For the Full license, see https://tldrlegal.com/license/aladdin-free-public-license#fulltext
The short human readable version of this licence for the benefit of the reader is:
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
integer g_CurrentFittedVagState=1;
integer g_CurrentFittedNipState=0;
list s_FittedVagooState=["BitState0","BitState1", "BitState2", "BitState3"];
/* NipAlpha unused with Kemono API; requires Starbright hud, which is a job for later*/
list s_FittedNipsState=["NipState0","Etc","NipState1"];
// Fitted Kemono Bits Add-On by Starbright (unimplemented ATM)
// list s_FittedCumLayers_Butt=["cumButtS1","cumButtS2","cumButtS3"];
#define xlGetLinkByPrimName(a) llList2Integer(g_LinkDB_l,(integer)(llListFindList(g_LinkDB_l,[(string)a])+1))
// OPTIMIZATION TODO: Use integer to pick list instead of passing list
lsShowOnlyIndex(list data, integer index)
{// Function by LogicShrimp
    list params = [];
    if(data == s_FittedNipsState)
    {
        list faces = xlGetFacesByBladeName(BLADE_NIPS);
        integer prim_id = xlGetLinkByBladeName(BLADE_NIPS);
        #ifdef DEBUG_FACE_SELECT
        llOwnerSay("FACES:"+llList2CSV(faces)+"\nPRIM_ID:"+(string)prim_id);
        #endif
        params += [PRIM_LINK_TARGET,prim_id,PRIM_COLOR,llList2Integer(faces,0),<1,1,1>,(index == 1)
                                            ,PRIM_COLOR,llList2Integer(faces,1),<1,1,1>,(index == 1)];
    }
    params += [PRIM_LINK_TARGET,xlGetLinkByPrimName(llList2String(data,index)),PRIM_COLOR,ALL_SIDES,<1,1,1>,TRUE];
    integer n = (data!=[]);//List length
    integer i = 1;
    for(;i < n; i++)
    {
        params += [PRIM_LINK_TARGET,xlGetLinkByPrimName(llList2String(data,(index + i) % n)),PRIM_COLOR,ALL_SIDES,<1,1,1>,FALSE];
    }
    xlSetLinkPrimitiveParamsFast(LINK_THIS,params);
}
xlSafeGenitalToggle(string name,integer showit)
{
    integer link_id;
    if(FITTED_COMBO)
    {
        if(name==BLADE_VAG)
        {
            // TODO: Restore last state (enhancement from stock behavior)
            string current_vag = llList2String(s_FittedVagooState,g_CurrentFittedVagState);
            lsShowOnlyIndex(s_FittedVagooState,showit);
        }
        else if (BLADE_NIPS)
        {
            /* Stock Body script:
            setnip0 == NipState0
            setnip1 == TorsoEtc[0,1]
            setnip2 == NipState1
            NipAlpha == ????
            */
            lsShowOnlyIndex(s_FittedNipsState,showit);
        }
    }
    else
    {
        llOwnerSay("unimplemented!");
    }
}
integer xlGetLinkByBladeName(string name)
{
    #ifdef DEBUG_FACE_SELECT
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
        // FIXME BUG: hides nipples instead of chest blade
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
    if(name==BLADE_NIPS)
    {
        if (FITTED_COMBO)
        {
            return [0,1];
        }
        return [2,3];
    }
    if(name==BLADE_PELVIS){
        // FIXME BUG: Hides nipples as well
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
            if(human_mode)
            {
                return [1];
            }
            else
            {
                return [7];
            }
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
            if(human_mode)
            {
                return [0];
            }
            else
            {
                return [6];
            }
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
    if(name==BLADE_ARM_L_L) return MESH_ARMS;
    if(name==BLADE_ARM_L_R) return MESH_ARMS;
    if(name==BLADE_ARM_U_L) return MESH_ARMS;
    if(name==BLADE_ARM_U_R) return MESH_ARMS;
    if(name==BLADE_ELBOW_L) return MESH_ARMS;
    if(name==BLADE_ELBOW_R) return MESH_ARMS;
    if(name==BLADE_WRIST_L) return MESH_ARMS;
    if(name==BLADE_WRIST_R) return MESH_ARMS;
    if(name==BLADE_RIBS)
    {
        if(FITTED_COMBO)
        {
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_ABS)
    {
        if(FITTED_COMBO)
        {
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_BODY)
    {
        if(FITTED_COMBO)
        {
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_BREASTS)
    {
        if(FITTED_COMBO)
        {
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_CHEST)
    {
        if(FITTED_COMBO)
        {
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_COLLAR)
    {
        if(FITTED_COMBO) return MESH_FITTED_TORSO;
        return MESH_NECK;
    }
    if(name==BLADE_HAND_LEFT) return MESH_HAND_LEFT;
    if(name==BLADE_HAND_RIGHT) return MESH_HAND_RIGHT;
    if(name==BLADE_HIP_L || name==BLADE_HIP_R){
        if(FITTED_COMBO)
        {
            // TODO: Restore current state (Improvement)
            // return "TorsoEtc";
            return llList2String(s_FittedVagooState,g_CurrentFittedVagState);
        }
        return MESH_HIPS;
    }
    if(name==BLADE_NECK)
    {
        if(FITTED_COMBO) return MESH_FITTED_TORSO;
        return MESH_NECK;
    }
    if(name==BLADE_PELVIS){
        // if(FITTED_COMBO) return "TorsoEtc";
        if(FITTED_COMBO){
            // TODO: Restore current state (Improvement)
            return llList2String(s_FittedVagooState,g_CurrentFittedVagState);
            // return "TorsoEtc";
        }
        return MESH_HIPS;
    }
    if(name==BLADE_KNEE_R)
    {
        if(human_mode)
        {
            return MESH_LEG_RIGHT_HUMAN;
        }
        else
        {
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_FOOT_R)
    {
        if(human_mode)
        {
            return MESH_LEG_RIGHT_HUMAN;
        }
        else
        {
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_ANKLE_R)
    {
        if(human_mode)
        {
            return MESH_LEG_RIGHT_HUMAN;
        }
        else
        {
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_U_R)
    {
        if(human_mode)
        {
            return MESH_LEG_RIGHT_HUMAN;
        }
        else
        {
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_CALF_R)
    {
        if(human_mode)
        {
            return MESH_LEG_RIGHT_HUMAN;
        }
        else
        {
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_L_R)
    {
        if(human_mode)
        {
            return MESH_LEG_RIGHT_HUMAN;
        }
        else
        {
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_CALF_L)
    {
        if(human_mode)
        {
            return MESH_LEG_LEFT_HUMAN;
        }
        else
        {
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_ANKLE_L)
    {
        if(human_mode)
        {
            return MESH_LEG_LEFT_HUMAN;
        }
        else
        {
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_FOOT_L)
    {
        if(human_mode)
        {
            return MESH_LEG_LEFT_HUMAN;
        }
        else
        {
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_KNEE_L)
    {
        if(human_mode)
        {
            return MESH_LEG_LEFT_HUMAN;
        }
        else
        {
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_L_L)
    {
        if(human_mode)
        {
            return MESH_LEG_LEFT_HUMAN;
        }
        else
        {
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_U_L)
    {
        if(human_mode)
        {
            return MESH_LEG_LEFT_HUMAN;
        }
        else
        {
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_SHOULDER_L_L){
        if(FITTED_COMBO) return MESH_FITTED_TORSO;
        return MESH_NECK;
    }
    if(name==BLADE_SHOULDER_L_R){
        if(FITTED_COMBO) return MESH_FITTED_TORSO;
        return MESH_NECK;
    }
    if(name==BLADE_SHOULDER_U_L){
        if(FITTED_COMBO) return MESH_FITTED_TORSO;
        return MESH_NECK;
    }
    if(name==BLADE_SHOULDER_U_R){
        if(FITTED_COMBO) return MESH_FITTED_TORSO;
        return MESH_NECK;
    }
    if(name==BLADE_THIGH_U_L){
        if(FITTED_COMBO) return "TorsoEtc";
        return MESH_HIPS;
    }
    if(name==BLADE_THIGH_U_R){
        if(FITTED_COMBO) return "TorsoEtc";
        return MESH_HIPS;
    }
    if(name==BLADE_BELLY)
    {
        if(FITTED_COMBO) return "TorsoEtc";
        return MESH_HIPS;
    }
    if(name==BLADE_NIPS)
    {
        if(FITTED_COMBO)
        {
            // TODO: Restore current state (Improvement)
            // return llList2String(s_FittedVagooState,g_CurrentFittedVagState);
            return "TorsoEtc";
        }
        return MESH_PG_LAYER;
    }
    if(name==BLADE_VAG)
    {
        if(FITTED_COMBO)
        {
            // TODO: Restore current state (Improvement)
            // return llList2String(s_FittedVagooState,g_CurrentFittedVagState);
            return "TorsoEtc";
        }
        return MESH_PG_LAYER;
    }
    if(name==BLADE_THIGH_L_R)
    {
        if(FITTED_COMBO)
        {
            if(human_mode)
            {
                return "HumanLegs";
            }
            else
            {
                return "TorsoEtc";
            }
        }
        else
        {
            // llOwnerSay("unimplemented!");
            return "WAT";?
            return MESH_HIPS;
        }
    }
    if(name==BLADE_THIGH_L_L)
    {
        if(FITTED_COMBO)
        {
            if(human_mode)
            {
                return "HumanLegs";
            }
            else
            {
                return "TorsoEtc";
            }
        }
        else
        {
            // llOwnerSay("unimplemented!");
            // return "WAT";
            return MESH_HIPS;
        }
    }
    llOwnerSay("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    return "WAT";
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
    else if(command=="setvag")
    {
        if (!FITTED_COMBO)
        {
            return;
        }
        lsShowOnlyIndex(s_FittedVagooState,llList2Integer(data,1));
        return;
    }
    else if(command=="setnip")
    {
        if (!FITTED_COMBO)
        {
            return;
        }
        lsShowOnlyIndex(s_FittedNipsState,llList2Integer(data,1));
        return;
    }
    else
    {
        return;
    }
    command="";
    list params;
    integer list_size = llGetListLength(data) - 1;
    for(;list_size >= 1; --list_size) /* skip first element*/
    {
        /* When linked against the Fitted Torso, we need to skip the parts handled by said torso
        *  to avoid endless toggling as the fitted torso requests hiding of the faces it replaces
        * to "fix" the stock body
        */
        string part_wanted_s = llList2String(data, list_size);
        // TODO: Write a better handling of this because we need to handle genitals
        // very carefully
        if(FITTED_COMBO && (part_wanted_s==BLADE_NIPS
                            || part_wanted_s==BLADE_BREASTS
                            || part_wanted_s==BLADE_VAG
                            )
        )
        {
            xlSafeGenitalToggle(part_wanted_s,showit);
        }
        else
        {
                list faces_l = xlGetFacesByBladeName(part_wanted_s);
                integer link_id = (integer)xlGetLinkByBladeName(part_wanted_s);
                #ifdef DEBUG_FACE_SELECT
                llOwnerSay("Faces List:"+llList2CSV(faces_l));
                llOwnerSay("Link ID  :"+(string)link_id);
                #endif
                integer faces = llGetListLength(faces_l) - 1;
                integer SHOW_WITH_VAGOO = showit ^ (BLADE_VAG==part_wanted_s); // No longer needed, is it?
                float SHOW_FOR_REAL = (SHOW_WITH_VAGOO * g_Config_MaximumOpacity);
                params+=[PRIM_LINK_TARGET,link_id];
                for(;faces>=0;--faces) {
                    params+=[PRIM_COLOR, llList2Integer(faces_l,faces), <1,1,1>, SHOW_FOR_REAL];
                }
        }
    }
    if(params!=[]) {
        xlSetLinkPrimitiveParamsFast(LINK_SET, params);
        params=[];
    }
}
default {
    #ifdef DEBUG_FACE_SELECT
    touch_start(integer total_number){
        key tk = llDetectedKey(0);
        if(tk!=g_Owner_k)return;
        llRegionSayTo(tk,0,
            "ID:"+(string)llDetectedLinkNumber(0)+";prim_name=\""+llGetLinkName(llDetectedLinkNumber(0))+"\";face_list=["+(string)llDetectedTouchFace(0)+"];break;");
    }
    #endif
    changed(integer change) {
        if (change & CHANGED_OWNER) {
            llOwnerSay("The owner of the object has changed, resetting...");
            llResetScript();
        }
        if(change & CHANGED_LINK)
        {
            llOwnerSay("Link changed, resetting..."); // should really just recalculate
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
                // if(~llSubStringIndex(name, MESH_FITTED_TORSO))
            }
            g_LinkDB_l+=[name,part];/* Typecast not optional; ensures that llList2* works as intended*/
        }
        #ifdef DEBUG
        llOwnerSay(llList2CSV(g_LinkDB_l));
        #endif
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
            if(!human_mode)
            {
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=TRUE;
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            }
        }
        else if(message=="Flegs"){
            if(human_mode)
            {
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=FALSE;
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            }
        }
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

/*<<<-------------------------Enlarge window so you see this on only one line for better visibility ------------------>>>>>*/
/* Aftermarket Kemono Body Script Replacement by Xenhat Liamano @ Second Life
 * Original creation date: 6/06/2017 22:52:37
 * Licensed under the Aladdin Free Public License Version 9
 * For the Full license, see https://tldrlegal.com/license/aladdin-free-public-license#fulltext
 * The short human readable version of this licence for the benefit of the reader is:
 *
 * You CAN:
 * Modify
 * Distribute
 *
 * You CANNOT:
 *  Hold Liable
 *  Sublicense
 *  Place Warranty
 *  Commercial Use
 * You MUST:
 *  Include License
 *  Include Original
 *  State Changes
 * An online version of the human-readable version of the AFPL can be found at:
 * https://tldrlegal.com/license/aladdin-free-public-license
 */
/* SCRIPT BEGINS HERE */
/* Runtime User Config starts here */
float g_Config_MaximumOpacity = 1.0; // 0.8 // for goo
/* Runtime User Config ends here */
/* Defines */
#define DEBUG 0
#define DEBUG_ENTIRE_BODY_ALPHA 0
#define DEBUG_LISTEN 0
#define DEBUG_PARAMS 0
#define DEBUG_FACE_SELECT 0
#define DEBUG_LISTEN_PROCESS 0
#define DEBUG_WHO 0
#define AUTH_ANYWAY 0
#define DEBUG_MEMORY 0
// End of debug defines
#define HOVER_TEXT_COLOR <0.825,0.825,0.825>
#define HOVER_TEXT_ALPHA 0.75
#if DEBUG_PARAMS
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
list g_supported_meshes = [
MESH_ARMS,
MESH_BODY,
MESH_HAND_LEFT,
MESH_HAND_RIGHT,
MESH_HIPS,
MESH_LEG_LEFT_ANIMAL,
MESH_LEG_LEFT_HUMAN,
MESH_LEG_RIGHT_ANIMAL,
MESH_LEG_RIGHT_HUMAN,
MESH_NECK,
MESH_PG_LAYER,
MESH_ROOT,
MESH_FITTED_TORSO,
"BitState0",
"BitState1",
"BitState2",
"BitState3",
"NipState0",
"TorsoEtc",
"NipState1",
"NipAlpha",
"cumButtS1",
"cumButtS2",
"cumButtS3"
];
integer g_PGState_Nips = FALSE;
integer FITTED_COMBO = FALSE;
integer g_HasAnimPerms = FALSE;
key g_Owner_k;
list g_RemConfirmKeys_l;
list g_LinkDB_l = [];

list s_FittedNipsMeshNames=[
"NipState0", /* PG */
"TorsoEtc", /* Adult, idle */
"NipState1", /* Adult, puffy */
"NipAlpha" /* Used in Starbright HUD/API */
];
list s_FittedVagooState=[
"BitState0", /* PG */
"BitState1", /* Adult, idle */
"BitState2", /* Adult, aroused */
"BitState3" /* Adult, gaping */
];
integer g_CurrentFittedNipState=1;
integer g_CurrentFittedVagState=1;
// Fitted Kemono Bits Add-On by Starbright (unimplemented ATM)
// list s_FittedCumLayers_Butt=["cumButtS1","cumButtS2","cumButtS3"];
// #define xlGetLinkByPrimName(a) llList2Integer(g_LinkDB_l,(integer)(llListFindList(g_LinkDB_l,[(string)a])+1))
integer xlGetLinkByPrimName(string a) {
    return llList2Integer(g_LinkDB_l,(integer)(llListFindList(g_LinkDB_l,[a])+1));
}
#define xlGetListLength(a) (a!=[])
list xlGetBladeToggleParams(list data, integer index, string bladename, integer showit)
{
    list faces_l = xlGetFacesByBladeName(bladename);
    integer prim_id = xlGetLinkByPrimName(llList2String(data,index));
    list params = [PRIM_LINK_TARGET,prim_id];
    integer len = xlGetListLength(faces_l);
    #if DEBUG_FACE_SELECT
    llOwnerSay("DATA:"+llList2CSV(data)+"\nINDEX:"+(string)index+"\nBLADENAME:"+bladename+"\nFACES:"+llList2CSV(faces_l)+"\nPRIM_ID:"+(string)prim_id+"\nSHOW:"+(string)showit);
    #endif
    for(;len > -1;len--)
    {
        params+=[PRIM_COLOR,llList2Integer(faces_l,len), <1,1,1>, showit];
    }
    return params;
}
// OPTIMIZATION TODO: Use integer to pick list instead of passing list
list lsShowOnlyIndex(list data, integer index, string bladename, integer showit){/* Function by LogicShrimp*/
    list params = [];
    params += xlGetBladeToggleParams(data,index,bladename, showit);
    integer n = (data!=[]);//List length
    integer i = 1;
    for(;i < n; i++){
        params += xlGetBladeToggleParams(data,((index + i) % n),bladename, FALSE);
    }
    return params;
}
integer xlGetLinkByBladeName(string name){
    /* TODO Can't we return the link number directly (using less than 512 bytes of code!) without an additional function call? */
    string prim_name = "UNIMPLEMENTED";
    if(name==BLADE_ARM_L_L) prim_name = MESH_ARMS;
    else if(name==BLADE_ARM_L_R) prim_name = MESH_ARMS;
    else if(name==BLADE_ARM_U_L) prim_name = MESH_ARMS;
    else if(name==BLADE_ARM_U_R) prim_name = MESH_ARMS;
    else if(name==BLADE_ELBOW_L) prim_name = MESH_ARMS;
    else if(name==BLADE_ELBOW_R) prim_name = MESH_ARMS;
    else if(name==BLADE_WRIST_L) prim_name = MESH_ARMS;
    else if(name==BLADE_WRIST_R) prim_name = MESH_ARMS;
    else if(name==BLADE_RIBS){
        if(FITTED_COMBO){
            prim_name = "TorsoChest";
        }
        else{
            prim_name = MESH_BODY;
        }
    }
    else if(name==BLADE_ABS){
        if(FITTED_COMBO){
            prim_name = "TorsoChest";
        }
        else{
            prim_name = MESH_BODY;
        }
    }
    else if(name==BLADE_BODY){
        if(FITTED_COMBO){
            prim_name = "TorsoChest";
        }
        else{
            prim_name = MESH_BODY;
        }
    }
    else if(name==BLADE_BREASTS){
        if(FITTED_COMBO){
            prim_name = "TorsoChest";
        }
        else{
            prim_name = MESH_BODY;
        }
    }
    else if(name==BLADE_CHEST){
        if(FITTED_COMBO){
            prim_name = "TorsoChest";
        }
        else{
            prim_name = MESH_BODY;
        }
    }
    else if(name==BLADE_COLLAR){
        if(FITTED_COMBO) prim_name = MESH_FITTED_TORSO;
        else{prim_name = MESH_NECK;}
    }
    else if(name==BLADE_HAND_LEFT) prim_name = MESH_HAND_LEFT;
    else if(name==BLADE_HAND_RIGHT) prim_name = MESH_HAND_RIGHT;
    else if(name==BLADE_HIP_L || name==BLADE_HIP_R){
        if(FITTED_COMBO){
            prim_name = llList2String(s_FittedVagooState,g_CurrentFittedVagState);
        }
        else{prim_name = MESH_HIPS;}
    }
    else if(name==BLADE_NECK){
        if(FITTED_COMBO) prim_name = MESH_FITTED_TORSO;
        else {prim_name = MESH_NECK;}
    }
    else if(name==BLADE_PELVIS){
        if(FITTED_COMBO){
            prim_name = llList2String(s_FittedVagooState,g_CurrentFittedVagState);
        }
        else{
            prim_name = MESH_HIPS;
        }
    }
    else if(name==BLADE_KNEE_R){
        if(human_mode){
            prim_name = MESH_LEG_RIGHT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_RIGHT_ANIMAL;
        }
    }
    else if(name==BLADE_FOOT_R){
        if(human_mode){
            prim_name = MESH_LEG_RIGHT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_RIGHT_ANIMAL;
        }
    }
    else if(name==BLADE_ANKLE_R){
        if(human_mode){
            prim_name = MESH_LEG_RIGHT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_RIGHT_ANIMAL;
        }
    }
    else if(name==BLADE_SHIN_U_R){
        if(human_mode){
            prim_name = MESH_LEG_RIGHT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_RIGHT_ANIMAL;
        }
    }
    else if(name==BLADE_CALF_R){
        if(human_mode){
            prim_name = MESH_LEG_RIGHT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_RIGHT_ANIMAL;
        }
    }
    else if(name==BLADE_SHIN_L_R){
        if(human_mode){
            prim_name = MESH_LEG_RIGHT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_RIGHT_ANIMAL;
        }
    }
    else if(name==BLADE_CALF_L){
        if(human_mode){
            prim_name = MESH_LEG_LEFT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_LEFT_ANIMAL;
        }
    }
    else if(name==BLADE_ANKLE_L){
        if(human_mode){
            prim_name = MESH_LEG_LEFT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_LEFT_ANIMAL;
        }
    }
    else if(name==BLADE_FOOT_L){
        if(human_mode){
            prim_name = MESH_LEG_LEFT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_LEFT_ANIMAL;
        }
    }
    else if(name==BLADE_KNEE_L){
        if(human_mode){
            prim_name = MESH_LEG_LEFT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_LEFT_ANIMAL;
        }
    }
    else if(name==BLADE_SHIN_L_L){
        if(human_mode){
            prim_name = MESH_LEG_LEFT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_LEFT_ANIMAL;
        }
    }
    else if(name==BLADE_SHIN_U_L){
        if(human_mode){
            prim_name = MESH_LEG_LEFT_HUMAN;
        }
        else{
            prim_name = MESH_LEG_LEFT_ANIMAL;
        }
    }
    else if(name==BLADE_SHOULDER_L_L){
        if(FITTED_COMBO) prim_name = MESH_FITTED_TORSO;
        else {prim_name = MESH_NECK;}
    }
    else if(name==BLADE_SHOULDER_L_R){
        if(FITTED_COMBO) prim_name = MESH_FITTED_TORSO;
        else {prim_name = MESH_NECK;}
    }
    else if(name==BLADE_SHOULDER_U_L){
        if(FITTED_COMBO) prim_name = MESH_FITTED_TORSO;
        else {prim_name = MESH_NECK;}
    }
    else if(name==BLADE_SHOULDER_U_R){
        if(FITTED_COMBO) prim_name = MESH_FITTED_TORSO;
        else {prim_name = MESH_NECK;}
    }
    else if(name==BLADE_THIGH_U_L){
        if(FITTED_COMBO) prim_name = "TorsoEtc";
        else{
            prim_name = MESH_HIPS;
        }
    }
    else if(name==BLADE_THIGH_U_R){
        if(FITTED_COMBO) prim_name = "TorsoEtc";
        else{
            prim_name = MESH_HIPS;
        }
    }
    else if(name==BLADE_BELLY){
        if(FITTED_COMBO) prim_name = "TorsoEtc";
        else{
            prim_name = MESH_HIPS;
        }
    }
    else if(name==BLADE_NIPS){
        if(FITTED_COMBO){
            /* TODO: use current nipple state */
            prim_name = "TorsoEtc";
        }
        else {
            prim_name = MESH_PG_LAYER;
        }
    }
    else if(name==BLADE_VAG){
        if(FITTED_COMBO){
            // prim_name = "TorsoEtc";
            prim_name = llList2String(s_FittedVagooState, g_CurrentFittedVagState);
        }
        else {
            prim_name = MESH_PG_LAYER;
        }
    }
    else if(name==BLADE_THIGH_L_R){
        if(FITTED_COMBO){
            if(human_mode){
                prim_name = "HumanLegs";
            }
            else{
                prim_name = "TorsoEtc";
            }
        }
        else{
            prim_name = MESH_HIPS;
        }
    }
    else if(name==BLADE_THIGH_L_L){
        if(FITTED_COMBO){
            if(human_mode){
                prim_name = "HumanLegs";
            }
            else{
                prim_name = "TorsoEtc";
            }
        }
        else{
            prim_name = MESH_HIPS;
        }
    }
    #if DEBUG_FACE_SELECT
    llOwnerSay("Blade To Prim Adapter Result:"+prim_name);
    #endif
    return llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[prim_name])+1);
}
integer human_mode = TRUE;
list xlGetFacesByBladeName(string name){
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
        // FIXME BUG: Nipples not in sync
        // if(FITTED_COMBO) return [0,1,2,3];
        if(FITTED_COMBO) return [2,3];
        else{return [2,5];}
    }
    if(name==BLADE_CALF_L)return [4];
    if(name==BLADE_CALF_R)return [4];
    if(name==BLADE_CHEST){
        if(FITTED_COMBO) return [0,1];
        else{return [0,4];}
    }
    if(name==BLADE_COLLAR){
        if(FITTED_COMBO) return [6,7];
        else{return [1,6];}
    }
    if(name==BLADE_ELBOW_L)return [4];
    if(name==BLADE_ELBOW_R)return [5];
    if(name==BLADE_FOOT_L)return [0];
    if(name==BLADE_FOOT_R)return [0];
    if(name==BLADE_HIP_L){
        if(FITTED_COMBO)return [5];
        else{return [6];}
    }
    if(name==BLADE_HIP_R){
        if(FITTED_COMBO)return [4];
        else{return [5];}
    }
    if(name==BLADE_KNEE_L)return [5];
    if(name==BLADE_KNEE_R)return [5];
    if(name==BLADE_HAND_LEFT)return [-1];
    if(name==BLADE_HAND_RIGHT)return [-1];
    if(name==BLADE_NECK){
        if(FITTED_COMBO) return [0,1];
        else{return [2,5];}
    }
    if(name==BLADE_NIPS){
        if (FITTED_COMBO){
            /* Note: Before changing this again, create a different way of handling
                the request that doesn't match. This is configured properly for the whole
                Fitted Torso chest mesh*/
            return [0,1];
        }
        else{return [2,3];}
    }
    if(name==BLADE_PELVIS){
        // FIXME BUG: Hides nipples as well
        if(FITTED_COMBO) return [0,1,2,3];
        else{return [0,1];}
    }
    if(name==BLADE_RIBS){
        if(FITTED_COMBO) return [4,5];
        else{return [1,3];}
    }
    if(name==BLADE_SHIN_L_L)return [2];
    if(name==BLADE_SHIN_L_R)return [2];
    if(name==BLADE_SHIN_U_L)return [3];
    if(name==BLADE_SHIN_U_R)return [3];
    if(name==BLADE_SHOULDER_L_L)return [3];
    if(name==BLADE_SHOULDER_L_R){
        if(FITTED_COMBO) return [2];
        else{return [0];}
    }
    if(name==BLADE_SHOULDER_U_L){
        if(FITTED_COMBO) return [5];
        else{return [7];}
    }
    if(name==BLADE_SHOULDER_U_R)return [4];
    if(name==BLADE_THIGH_L_L){
        if(FITTED_COMBO){
            if(human_mode){
                return [1];
            }
            else{
                return [7];
            }
        }
        else{
            if(human_mode){
                return [6];
            }
            else {
                return [];
            }
        }
    }
    if(name==BLADE_THIGH_L_R){
        if(FITTED_COMBO){
            if(human_mode){
                return [0];
            }
            else{
                return [6];
            }
        }
        else {
            if(human_mode){
                return [6];
            }
            else {
                return [];
            }
        }
    }
    if(name==BLADE_THIGH_U_L){
        if(FITTED_COMBO)return [5];
        else{return [7];}
    }
    if(name==BLADE_THIGH_U_R)return [4];
    if(name==BLADE_VAG) {
        if(FITTED_COMBO){
            return [0,1,2,3,4,5];
        }
        else
        {
            return [0,1];
        }
    }
    if(name==BLADE_WRIST_L)return [3];
    if(name==BLADE_WRIST_R)return [1];
    llOwnerSay("UNIMPLEMENTED:"+name+"!");
    return [];
}
xlProcessCommand(string message){
    list data = llParseStringKeepNulls(message,[":"],[]);
    integer showit = TRUE; // Fix bug with Fitted Torso hud
    string command = llList2String(data,0);
    if(command == "show"){
        showit = TRUE;
    }
    else if(command == "hide"){
        showit = FALSE;
    }
    else if(command=="setvag"){
        if (!FITTED_COMBO){
            return;
        }
        /* FIXME: Toggles the entire mesh instead of the upper faces */
        g_CurrentFittedVagState = llList2Integer(data,1);
        list params = lsShowOnlyIndex(s_FittedVagooState,g_CurrentFittedVagState,BLADE_VAG, TRUE);
        xlSetLinkPrimitiveParamsFast(LINK_THIS,params);
        return;
    }
    else if(command=="setnip"){
        if (!FITTED_COMBO){
            return;
        }
        g_CurrentFittedNipState = llList2Integer(data,1);
        list params = lsShowOnlyIndex(s_FittedNipsMeshNames,g_CurrentFittedNipState,BLADE_NIPS,TRUE);
        xlSetLinkPrimitiveParamsFast(LINK_THIS,params);
        return;
    }
    else{
        return;
    }
    command="";
    list params;
    integer list_size = xlGetListLength(data) - 1;
    string part_wanted_s = llList2String(data, 0);
    if(part_wanted_s == BLADE_NIPS)
    {
        g_PGState_Nips = !showit;
        llSetObjectDesc((string)g_PGState_Nips);
    }
    for(;list_size >= 1; --list_size){ /* skip first element*/
        /* When linked against the Fitted Torso, we need to skip the parts handled by said torso
        *  to avoid endless toggling as the fitted torso requests hiding of the faces it replaces
        * to "fix" the stock body
        */
        /* TODO: Optimize the param creation logic to not include redundant changes.
        *  This implies making it so that there is no post-loop "fixing" happening.
        */
        part_wanted_s = llList2String(data, list_size);
        #if DEBUG_FACE_SELECT
        llOwnerSay("part wanted:"+part_wanted_s);
        #endif
        if(FITTED_COMBO && part_wanted_s==BLADE_VAG){
            lsShowOnlyIndex(s_FittedVagooState,g_CurrentFittedVagState,part_wanted_s, showit);
        }
        else if (FITTED_COMBO && part_wanted_s==BLADE_NIPS){
            /* Stock Fitted Torso script:
            setnip0 == NipState0
            setnip1 == TorsoEtc[0,1]
            setnip2 == NipState1
            NipAlpha == ????
            */
            /* Note: The Starbright stock behavior is the following:
                * Show PG layer when hiding nipples
                * Forcefully set the current nipple type to Adult, idle on PG disable
            */
            /* Should be dynamic index, but let's save some precious cycles*/
            // if(!showit){
                params = lsShowOnlyIndex(s_FittedNipsMeshNames,showit, part_wanted_s, TRUE);
            // }
            // else{
                
                // params = lsShowOnlyIndex(s_FittedNipsMeshNames,1, part_wanted_s, FALSE);
            // }
        }
        else if (FITTED_COMBO && part_wanted_s==BLADE_BREASTS){
           lsShowOnlyIndex(s_FittedNipsMeshNames,g_CurrentFittedNipState, part_wanted_s, showit);
        }
        list faces_l = xlGetFacesByBladeName(part_wanted_s);
        integer link_id = (integer)xlGetLinkByBladeName(part_wanted_s);
        #if DEBUG_FACE_SELECT
        llOwnerSay("Faces List:"+llList2CSV(faces_l));
        llOwnerSay("Link ID  :"+(string)link_id);
        #endif
        integer faces = xlGetListLength(faces_l) - 1;
        integer SHOW_WITH_VAGOO = showit ^ (BLADE_VAG==part_wanted_s); // No longer needed, is it?
        float SHOW_FOR_REAL = (SHOW_WITH_VAGOO * g_Config_MaximumOpacity);
        params+=[PRIM_LINK_TARGET,link_id];
        for(;faces>=0;--faces){
            params+=[PRIM_COLOR, llList2Integer(faces_l,faces), <1,1,1>, SHOW_FOR_REAL];
        }
    }
    if(params!=[]){
        xlSetLinkPrimitiveParamsFast(LINK_SET, params);
        params=[];
    }
}
default {
    #if DEBUG_FACE_SELECT
    touch_start(integer total_number){
        key tk = llDetectedKey(0);
        if(tk!=g_Owner_k)return;
        llRegionSayTo(tk,0,
            "ID:"+(string)llDetectedLinkNumber(0)+";prim_name=\""+llGetLinkName(llDetectedLinkNumber(0))+"\";face_list=["+(string)llDetectedTouchFace(0)+"];break;");
    }
    #endif
    changed(integer change){
        if (change & CHANGED_OWNER){
            llOwnerSay("The owner of the object has changed, resetting...");
            llResetScript();
        }
        if(change & CHANGED_LINK){
            llOwnerSay("Link changed, resetting..."); // should really just recalculate
            llResetScript();
        }
    }
    state_entry(){
#if DEBUG_MEMORY
        llScriptProfiler(PROFILE_SCRIPT_MEMORY);
#else
        llScriptProfiler(PROFILE_NONE);
#endif
        llSetText("Please wait...",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        g_Owner_k = llGetOwner();
        #if DEBUG
        llOwnerSay("Counting");
        #endif
        human_mode=(integer)llGetObjectDesc();
        integer part = llGetNumberOfPrims();
        #if DEBUG_ENTIRE_BODY_ALPHA
        string texture = llGetInventoryName(INVENTORY_TEXTURE,0);
        integer retexture = texture != "";
        list prim_params_to_apply = [];
        #endif
        for (; part > 0; --part){
            string name = llGetLinkName(part);
            llSetText("\n \n \n \n \n \nProcessing " + name + "...",<0,0,0>,1.0);
            integer fitted_torso_string_index = llSubStringIndex(name, MESH_FITTED_TORSO);
            if(fitted_torso_string_index != -1){
                /* Look if this really is a fitted torso or an accessory for it */
                if(fitted_torso_string_index == 6 || fitted_torso_string_index == 7){
                    /* We are linked with starnya's Fitted Torso*/
                    FITTED_COMBO=TRUE;
                    name=MESH_FITTED_TORSO;
                }
            }
            if(llListFindList(g_supported_meshes, [name])!= 1){
                #if DEBUG_ENTIRE_BODY_ALPHA
                prim_params_to_apply += [PRIM_LINK_TARGET,part,PRIM_COLOR,ALL_SIDES,<1,1,1>,0.0];
                if(retexture){
                    prim_params_to_apply+= [PRIM_TEXTURE,ALL_SIDES, texture, <1,1,0>,<0,0,0>,0.0]; // LL, Standards plz...
                }
                #endif
                g_LinkDB_l+=[name,part];/* Typecast not optional; ensures that llList2* works as intended*/
            }
        }
        #if DEBUG
        llOwnerSay("Link database: " + llList2CSV(g_LinkDB_l));
        #endif
        #if DEBUG_ENTIRE_BODY_ALPHA
        llSetLinkPrimitiveParamsFast(LINK_ROOT, prim_params_to_apply);
        /* Reset faces*/
        /* Warning: This command contains an additional "show:nips" and "show:vagoo:" not desired in the reset command*/
        /* TODO: Persistent storage for states to avoid resetting everything to have a consistent state */
        // xlProcessCommand("show:nips:vagoo:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        xlProcessCommand("show:nips:vagoo");
        #endif
        /* The Starbright body Stripper has an option to leave the human legs out,
            so check if these are present at all*/
        /* FIXME: Undefined behavior if no legs from kemono body */
        if(llListFindList(g_LinkDB_l, [MESH_LEG_RIGHT_HUMAN]) == -1)
        {
            /* Forcefully set to human mode if the animal legs aren't found*/
            human_mode=FALSE;
        }
        else if(llListFindList(g_LinkDB_l, [MESH_LEG_RIGHT_ANIMAL]) == -1)
        {
            /* Forcefully set to animal mode if the human legs aren't found*/
            human_mode=TRUE;
        }
        /* I used texture because TEXTURE_TRANSPARENT tends to disappear totally on some
            viewers, which is preferable. */
        if(llGetAttached()){
            llSetLinkTexture(LINK_ROOT, TEXTURE_TRANSPARENT, ALL_SIDES);
        }
        else {
            llSetLinkTexture(LINK_ROOT, TEXTURE_BLANK, ALL_SIDES);
        }
        llListen(KEMONO_COM_CH,"","","");
        llSetText("",HOVER_TEXT_COLOR,0.0);
        llSetTimerEvent(0.1);
    }
    listen( integer channel, string name, key id, string message ){
        key owner_key = llGetOwnerKey(id);
        if (id == llGetKey()) return;
        #if DEBUG_LISTEN
        string knp;
        #if DEBUG_WHO
        knp = "["+(string)id+"]"+"{"+llKey2Name(id)+"}(secondlife:///app/agent/"+(string)llGetOwnerKey(id)+"/inspect) ";
        #endif
        llOwnerSay(knp+"input ["+message+"]");
        #endif
        /* Ignore Starbright's Kemono Torso messages when handling that mesh*/
        if(FITTED_COMBO){
            if(llSubStringIndex(name,MESH_FITTED_TORSO) > 3){
                return;
            }
        }
        /*If we can't get a valid owner...*/
        if(owner_key == id){
            /*And if they aren't in the auth list, ignore them.*/
            if(llListFindList(g_RemConfirmKeys_l,[id]) == -1){
                return;
            }
        }
        /*If they don't have the same owner, ignore them.*/
        else if(owner_key != g_Owner_k){
            return;
        }
        if(message == "add"){
            /*And if they aren't in the auth list, add them.*/
            if(llListFindList(g_RemConfirmKeys_l,[id]) == -1){
                g_RemConfirmKeys_l += [id];
                return;
            }
        }
        if(message == "remove"){
            /*If the are in the list, remove them.*/
            integer placeinlist = llListFindList(g_RemConfirmKeys_l, [(key)id]);
            if (placeinlist != -1){
                g_RemConfirmKeys_l = llDeleteSubList(g_RemConfirmKeys_l, placeinlist, placeinlist);
            }
        }
        if (message=="Hlegs"){
            if(!human_mode){
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=TRUE;
                llSetObjectDesc("1");
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            }
        }
        else if(message=="Flegs"){
            if(human_mode){
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=FALSE;
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                llSetObjectDesc("0");
            }
        }
        /* Restore compatibility with old scripts*/
        else if(message=="resetA"){
            xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        }
        else if(message=="resetB"){
            xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
            g_RemConfirmKeys_l=[];
        }
        else {
            xlProcessCommand(message);
            #if DEBUG_LISTEN_PROCESS
            llOwnerSay("Sucessfully consumed "+knp+"'s [http://"+message+" command]");
            #endif
        }
    }
    attach(key id) {
        if(id == NULL_KEY)
        {
            // if(g_HasAnimPerms) {/* Proper, but we're running against the clock here */
                llStopAnimation("Kem-body-deform");
                llStartAnimation("Kem-body-undeform");
                llStopAnimation("Kem-body-undeform");
                return;
            //}
        }
        llSetTimerEvent(0.1);
    }
    run_time_permissions(integer perm){
        if (perm & PERMISSION_TRIGGER_ANIMATION){
            g_HasAnimPerms=TRUE;
            llSetText("Applying Deform Animation...", HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
            llStartAnimation("Kem-body-deform");
        }
    }

    timer(){
        if(DEBUG ||DEBUG_LISTEN ||DEBUG_PARAMS ||DEBUG_FACE_SELECT ||DEBUG_LISTEN_PROCESS ||DEBUG_WHO ||AUTH_ANYWAY ||DEBUG_MEMORY){
        string text = "[DEBUG]";
#if DEBUG_MEMORY
            integer used_memory = llGetUsedMemory();
            integer max_memory = llGetSPMaxMemory();
            text+="\nU: "+(string)used_memory+"["+(string)max_memory+"]/"+(string)llGetMemoryLimit()+"B"
                + "\n--------"
                +"\n"+(string)xlGetListLength(g_RemConfirmKeys_l)+" Keys\n \n ";
        /*if(!llSetMemoryLimit(max_memory+1024)){
            llOwnerSay("Running out of memory! You should probably mention this to secondlife:///app/agent/f1a73716-4ad2-4548-9f0e-634c7a98fe86/inspect...");
        }*/
#endif // DEBUG_MEMORY
            llSetText(text, HOVER_TEXT_COLOR, HOVER_TEXT_ALPHA);
        }else{
            llSetText("", HOVER_TEXT_COLOR, 0.0);
        }
        g_HasAnimPerms = llGetPermissions();
        if(llGetAttached() && !g_HasAnimPerms)llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
        llSetTimerEvent(3);
    }
}

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
#define DEBUG 0
#define DEBUG_LISTEN 0
#define DEBUG_PARAMS 0
#define DEBUG_FACE_SELECT 0
#define DEBUG_LISTEN_PROCESS 0
#define DEBUG_WHO 0
#define AUTH_ANYWAY 0
#define DEBUG_MEMORY 0
// End of debug defines
#define HOVER_TEXT_COLOR <0.25,0.25,0.25>
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
"Etc",
"NipState1",
"cumButtS1",
"cumButtS2",
"cumButtS3"
];

integer g_State_PG = TRUE;
integer FITTED_COMBO = FALSE;
integer g_HasAnimPerms = FALSE;
key g_Owner_k;
list g_RemConfirmKeys_l;
list g_LinkDB_l = [];
integer g_CurrentFittedVagState=1;
integer g_CurrentFittedNipState=1;
list s_FittedVagooState=["BitState0","BitState1", "BitState2", "BitState3"];
/* NipAlpha unused with Kemono API; requires Starbright hud, which is a job for later*/
list s_FittedNipsState=["NipState0","Etc","NipState1"];
// Fitted Kemono Bits Add-On by Starbright (unimplemented ATM)
// list s_FittedCumLayers_Butt=["cumButtS1","cumButtS2","cumButtS3"];
#define xlGetLinkByPrimName(a) llList2Integer(g_LinkDB_l,(integer)(llListFindList(g_LinkDB_l,[(string)a])+1))
// OPTIMIZATION TODO: Use integer to pick list instead of passing list
lsShowOnlyIndex(list data, integer index){/* Function by LogicShrimp*/
    list params = [];
    if(data == s_FittedNipsState){
        list faces_l = xlGetFacesByBladeName(BLADE_NIPS);
        integer prim_id = xlGetLinkByBladeName(BLADE_NIPS);
        #if DEBUG_FACE_SELECT
        llOwnerSay("NAME:"+llList2CSV(data)+"\nFACES:"+llList2CSV(faces_l)+"\nPRIM_ID:"+(string)prim_id);
        #endif
        params += [PRIM_LINK_TARGET,prim_id,PRIM_COLOR,llList2Integer(faces_l,0),<1,1,1>,(index = 1)
                                            ,PRIM_COLOR,llList2Integer(faces_l,1),<1,1,1>,(index == 1)];
    }
    params += [PRIM_LINK_TARGET,xlGetLinkByPrimName(llList2String(data,index)),PRIM_COLOR,ALL_SIDES,<1,1,1>,TRUE];
    integer n = (data!=[]);//List length
    integer i = 1;
    for(;i < n; i++){
        params += [PRIM_LINK_TARGET,xlGetLinkByPrimName(llList2String(data,(index + i) % n)),PRIM_COLOR,ALL_SIDES,<1,1,1>,FALSE];
    }
    xlSetLinkPrimitiveParamsFast(LINK_THIS,params);
}
xlSafeGenitalToggle(string name,integer showit){
    integer link_id;
    if(FITTED_COMBO && name==BLADE_VAG){
            // TODO: Restore last state (enhancement from stock behavior)
            string current_vag = llList2String(s_FittedVagooState,g_CurrentFittedVagState);
            lsShowOnlyIndex(s_FittedVagooState,showit);
        }
    else if (FITTED_COMBO && (name==BLADE_NIPS || name==BLADE_BREASTS)){
            /* Stock Body script:
            setnip0 == NipState0
            setnip1 == TorsoEtc[0,1]
            setnip2 == NipState1
            NipAlpha == ????
            */
            // lsShowOnlyIndex(s_FittedNipsState,showit * g_CurrentFittedNipState);
            // lsShowOnlyIndex(s_FittedNipsState,1);
            lsShowOnlyIndex(s_FittedNipsState,showit);
            // lsShowOnlyIndex(s_FittedNipsState,3);
        }
    else{
        llOwnerSay("unimplemented!:" + name);
    }
}
integer xlGetLinkByBladeName(string name){
    #if DEBUG_FACE_SELECT
    integer index = llListFindList(g_LinkDB_l,[xlGetPrimNameByBladeName(name)]);
    integer id = llList2Integer(g_LinkDB_l,index+1);
    llOwnerSay("Wanted:"+name+"\n"+
    "Index: :"+(string)index+"\n"+
    "Returning ID:"+(string)id+"\n");
    return id;
    #else
        return llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[xlGetPrimNameByBladeName(name)])+1);
    #endif
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
        // FIXME BUG: hides nipples instead of chest blade
        if(FITTED_COMBO) return [0,1,2,3];
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
    if(name==BLADE_NIPS){
        if (FITTED_COMBO){
            /* Note: Before changing this again, create a different way of handling
                the request that doesn't match. This is configured properly for the whole
                Fitted Torso chest mesh*/
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
        if(FITTED_COMBO){
            if(human_mode){
                return [1];
            }
            else{
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
        if(FITTED_COMBO){
            if(human_mode){
                return [0];
            }
            else{
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
string xlGetPrimNameByBladeName(string name){
    if(name==BLADE_ARM_L_L) return MESH_ARMS;
    if(name==BLADE_ARM_L_R) return MESH_ARMS;
    if(name==BLADE_ARM_U_L) return MESH_ARMS;
    if(name==BLADE_ARM_U_R) return MESH_ARMS;
    if(name==BLADE_ELBOW_L) return MESH_ARMS;
    if(name==BLADE_ELBOW_R) return MESH_ARMS;
    if(name==BLADE_WRIST_L) return MESH_ARMS;
    if(name==BLADE_WRIST_R) return MESH_ARMS;
    if(name==BLADE_RIBS){
        if(FITTED_COMBO){
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_ABS){
        if(FITTED_COMBO){
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_BODY){
        if(FITTED_COMBO){
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_BREASTS){
        if(FITTED_COMBO){
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_CHEST){
        if(FITTED_COMBO){
            return "TorsoChest";
        }
        else{
            return MESH_BODY;
        }
    }
    if(name==BLADE_COLLAR){
        if(FITTED_COMBO) return MESH_FITTED_TORSO;
        return MESH_NECK;
    }
    if(name==BLADE_HAND_LEFT) return MESH_HAND_LEFT;
    if(name==BLADE_HAND_RIGHT) return MESH_HAND_RIGHT;
    if(name==BLADE_HIP_L || name==BLADE_HIP_R){
        if(FITTED_COMBO){
            // TODO: Restore current state (Improvement)
            // return "TorsoEtc";
            return llList2String(s_FittedVagooState,g_CurrentFittedVagState);
        }
        return MESH_HIPS;
    }
    if(name==BLADE_NECK){
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
    if(name==BLADE_KNEE_R){
        if(human_mode){
            return MESH_LEG_RIGHT_HUMAN;
        }
        else{
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_FOOT_R){
        if(human_mode){
            return MESH_LEG_RIGHT_HUMAN;
        }
        else{
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_ANKLE_R){
        if(human_mode){
            return MESH_LEG_RIGHT_HUMAN;
        }
        else{
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_U_R){
        if(human_mode){
            return MESH_LEG_RIGHT_HUMAN;
        }
        else{
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_CALF_R){
        if(human_mode){
            return MESH_LEG_RIGHT_HUMAN;
        }
        else{
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_L_R){
        if(human_mode){
            return MESH_LEG_RIGHT_HUMAN;
        }
        else{
            return MESH_LEG_RIGHT_ANIMAL;
        }
    }
    if(name==BLADE_CALF_L){
        if(human_mode){
            return MESH_LEG_LEFT_HUMAN;
        }
        else{
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_ANKLE_L){
        if(human_mode){
            return MESH_LEG_LEFT_HUMAN;
        }
        else{
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_FOOT_L){
        if(human_mode){
            return MESH_LEG_LEFT_HUMAN;
        }
        else{
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_KNEE_L){
        if(human_mode){
            return MESH_LEG_LEFT_HUMAN;
        }
        else{
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_L_L){
        if(human_mode){
            return MESH_LEG_LEFT_HUMAN;
        }
        else{
            return MESH_LEG_LEFT_ANIMAL;
        }
    }
    if(name==BLADE_SHIN_U_L){
        if(human_mode){
            return MESH_LEG_LEFT_HUMAN;
        }
        else{
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
    if(name==BLADE_BELLY){
        if(FITTED_COMBO) return "TorsoEtc";
        return MESH_HIPS;
    }
    if(name==BLADE_NIPS){
        if(FITTED_COMBO){
            return "TorsoEtc";
        }
        return MESH_PG_LAYER;
    }
    if(name==BLADE_VAG){
        if(FITTED_COMBO){
            return "TorsoEtc";
        }
        return MESH_PG_LAYER;
    }
    if(name==BLADE_THIGH_L_R){
        if(FITTED_COMBO){
            if(human_mode){
                return "HumanLegs";
            }
            else{
                return "TorsoEtc";
            }
        }
        else{
            return MESH_HIPS;
        }
    }
    if(name==BLADE_THIGH_L_L){
        if(FITTED_COMBO){
            if(human_mode){
                return "HumanLegs";
            }
            else{
                return "TorsoEtc";
            }
        }
        else{
            return MESH_HIPS;
        }
    }
    llOwnerSay("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    return "WAT";
}
xlProcessCommand(string message){
    list data = llParseStringKeepNulls(message,[":"],[]);
    integer showit;
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
        lsShowOnlyIndex(s_FittedVagooState,llList2Integer(data,1));
        return;
    }
    else if(command=="setnip"){
        if (!FITTED_COMBO){
            return;
        }
        lsShowOnlyIndex(s_FittedNipsState,llList2Integer(data,1));
        return;
    }
    else{
        return;
    }
    command="";
    list params;
    integer list_size = llGetListLength(data) - 1;
    for(;list_size >= 1; --list_size) /* skip first element*/{
        /* When linked against the Fitted Torso, we need to skip the parts handled by said torso
        *  to avoid endless toggling as the fitted torso requests hiding of the faces it replaces
        * to "fix" the stock body
        */
        string part_wanted_s = llList2String(data, list_size);
        // else{
                list faces_l = xlGetFacesByBladeName(part_wanted_s);
                integer link_id = (integer)xlGetLinkByBladeName(part_wanted_s);
                #if DEBUG_FACE_SELECT
                llOwnerSay("Faces List:"+llList2CSV(faces_l));
                llOwnerSay("Link ID  :"+(string)link_id);
                #endif
                integer faces = llGetListLength(faces_l) - 1;
                integer SHOW_WITH_VAGOO = showit ^ (BLADE_VAG==part_wanted_s); // No longer needed, is it?
                float SHOW_FOR_REAL = (SHOW_WITH_VAGOO * g_Config_MaximumOpacity);
                params+=[PRIM_LINK_TARGET,link_id];
                for(;faces>=0;--faces){
                    params+=[PRIM_COLOR, llList2Integer(faces_l,faces), <1,1,1>, SHOW_FOR_REAL];
                }
        // }
        // TODO: Write a better handling of this because we need to handle genitals
        // very carefully
        if(FITTED_COMBO && (part_wanted_s==BLADE_NIPS
                            || part_wanted_s==BLADE_BREASTS
                            || part_wanted_s==BLADE_VAG
                            )
        ){
            xlSafeGenitalToggle(part_wanted_s,showit);
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
        llSetTimerEvent(3);
        #if DEBUG
        llOwnerSay("Counting");
        #endif
        human_mode=(integer)llGetObjectDesc();
        integer part = llGetNumberOfPrims();
        string texture = llGetInventoryName(INVENTORY_TEXTURE,0);
        integer retexture = texture != "";
        list prim_params_to_apply = [];
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
                prim_params_to_apply += [PRIM_LINK_TARGET,part,PRIM_COLOR,ALL_SIDES,<1,1,1>,0.0];
                if(retexture){
                    prim_params_to_apply+= [PRIM_TEXTURE,ALL_SIDES, texture, <1,1,0>,<0,0,0>,0.0]; // LL, Standards plz...
                }
                g_LinkDB_l+=[name,part];/* Typecast not optional; ensures that llList2* works as intended*/
            }
        }
        llSetLinkPrimitiveParamsFast(LINK_ROOT, prim_params_to_apply);
        #if DEBUG
        llOwnerSay("Link database: " + llList2CSV(g_LinkDB_l));
        #endif
        /* The Starbright body Stripper has an option to leave the human legs out,
            so check if these are present at all*/
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
        /* FIXME: Undefined behavior if no legs from kemono body */
        /* I used texture because TEXTURE_TRANSPARENT tends to disappear totally on some
            viewers, which is preferable. */
        if(llGetAttached()){
            llSetLinkTexture(LINK_ROOT, TEXTURE_TRANSPARENT, ALL_SIDES);
        }
        else {
            llSetLinkTexture(LINK_ROOT, TEXTURE_BLANK, ALL_SIDES);
        }
        /* Reset faces*/
        xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        llListen(KEMONO_COM_CH,"","","");
        llSetText("",HOVER_TEXT_COLOR,0.0);
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
    run_time_permissions(integer perm){
        if (perm & PERMISSION_TRIGGER_ANIMATION){
            g_HasAnimPerms=TRUE;
            if(llGetAttached()){
                llSetText("Applying Deform Animation...", HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
                llStartAnimation("Kem-body-deform");
            }
            else {
                llStopAnimation("Kem-body-deform");
                llStartAnimation("Kem-body-undeform");
                llStopAnimation("Kem-body-undeform");
            }
        }
    }
    attach(key id) {
        if(id == NULL_KEY)
        {
            if(g_HasAnimPerms)
            {
                llStopAnimation("Kem-body-deform");
                llStartAnimation("Kem-body-undeform");
                llStopAnimation("Kem-body-undeform");
            }
        }
    }
    timer(){
        if(DEBUG ||DEBUG_LISTEN ||DEBUG_PARAMS ||DEBUG_FACE_SELECT ||DEBUG_LISTEN_PROCESS ||DEBUG_WHO ||AUTH_ANYWAY ||DEBUG_MEMORY){
            llSetText("[DEBUG]", HOVER_TEXT_COLOR, HOVER_TEXT_ALPHA);
        }else{
            llSetText("", HOVER_TEXT_COLOR, 0.0);
        }
        g_HasAnimPerms = llGetPermissions();
        if(llGetAttached() && !g_HasAnimPerms)llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
#if DEBUG_MEMORY
        llSetText((string)llGetUsedMemory()+"B\n["+(string)llGetSPMaxMemory()+"B]\n-----------\n"+(string)llGetMemoryLimit()+"B\n-----------\n"+(string)llGetListLength(g_RemConfirmKeys_l)+" Keys\nAttached:"+(string)llGetAttached(),HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
#else
        //if(!llSetMemoryLimit(llGetUsedMemory()+256))
        //{
        //    llOwnerSay("Running out of memory! You should probably mention this to secondlife:///app/agent/f1a73716-4ad2-4548-9f0e-634c7a98fe86/inspect...");
        //}
#endif
    }
}
